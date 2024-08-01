class TransactionsController < ApplicationController
  before_action :set_bank_account
  has_scope :by_type, as: 'type'
  has_scope :by_min_amount, as: 'min_amount'
  has_scope :by_max_amount, as: 'max_amount'
  has_scope :by_start_date, as: 'start_date'
  has_scope :by_end_date, as: 'end_date'
  has_scope :sorted_by, using: %i[sort_column sort_direction], default: %w[created_at desc], type: :hash

  def index
    transactions = apply_scopes(@bank_account.transactions).order("#{sort_column} #{sort_direction}")
    decorated_transactions = TransactionDecorator.decorate_collection(transactions)
    @transactions = Kaminari.paginate_array(decorated_transactions).page(params[:page]).per(10)

  end

  def new
    @transaction = @bank_account.transactions.build
  end

  def create
    @transaction = @bank_account.transactions.build(transaction_params)
    process_and_redirect_or_render(@transaction, :new)
  end

  def new_withdrawal
    @transaction = @bank_account.transactions.build
  end

  def withdrawal
    @transaction = build_withdrawal_transaction
    process_and_redirect_or_render(@transaction, :new)
  end

  def transfer_account
    @transaction = @bank_account.transactions.build
  end

  def transfer_phone
    @transaction = @bank_account.transactions.build
  end

  def transfer_by_phone_number
    recipient_client = Client.find_by(phone_number: params[:transaction][:recipient_number_phone])
    @transaction = @bank_account.transactions.build
    return render :new if recipient_client.nil?

    recipient_account = recipient_client&.bank_accounts&.first
    return render :new if recipient_account.nil?

    @transaction = @bank_account.transactions.build
    process_transfer(recipient_account)
  end

  private

  def process_transfer(recipient_account)
    render :transfer_account if recipient_account.nil?
    @transaction = build_transaction(recipient_account.id)
    process_and_redirect_or_render(@transaction, :transfer_account) do
      update_recipient_balance_and_log_transaction(recipient_account, @transaction.amount)
    end
  end

  def sort_transactions(transactions)
    sort_column = params[:sort_column] || 'created_at'
    sort_direction = params[:sort_direction] || 'desc'
    transactions.order("#{sort_column} #{sort_direction}")
  end

  def build_withdrawal_transaction
    @bank_account.transactions.build(transaction_params).tap do |transaction|
      transaction.transaction_type = 'Снятие'
      transaction.sender_id = @bank_account.id
    end
  end

  def process_successful_transaction
    @bank_account.update(balance: @bank_account.balance - @transaction.amount)
  end

  def update_recipient_balance_and_log_transaction(recipient_account, amount)
    recipient_account.update(balance: recipient_account.balance + amount)
    recipient_account.transactions.create!(
      amount: amount, transaction_type: 'Получение',
      sender_id: @bank_account.id, recipient_id: recipient_account.id
    )
  end

  def set_bank_account
    @bank_account = BankAccount.find(params[:bank_account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type)
  end

  def build_transaction(recipient_id)
    @bank_account.transactions.build(transaction_params).tap do |transaction|
      transaction.sender_id = @bank_account.id
      transaction.recipient_id = recipient_id
    end
  end

  def filter_transactions(transactions)
    filtered_transactions = transactions
    apply_transaction_type_filter(filtered_transactions)
    apply_amount_filters(filtered_transactions)
    apply_date_filters(filtered_transactions)
    filtered_transactions
  end

  def apply_transaction_type_filter(transactions)
    transactions.where!(transaction_type: params[:type]) if params[:type].present?
  end

  def apply_amount_filters(transactions)
    transactions.where!(amount: params[:min_amount].to_f..) if params[:min_amount].present?
    transactions.where!(amount: ..params[:max_amount].to_f) if params[:max_amount].present?
  end

  def apply_date_filters(transactions)
    transactions.where!(created_at: Date.parse(params[:start_date])..) if params[:start_date].present?
    transactions.where!(created_at: ..Date.parse(params[:end_date]).end_of_day) if params[:end_date].present?
  end

  def find_recipient_account
    recipient_account = BankAccount.find_by(account_number: params[:transaction][:recipient_account_number])
    if recipient_account.nil?
      recipient_client = Client.find_by(phone_number: params[:transaction][:recipient_number_phone])
      recipient_account = recipient_client.bank_accounts.first if recipient_client
    end
    recipient_account
  end

  def process_and_redirect_or_render(transaction, action)
    if transaction.save
      process_successful_transaction
      yield if block_given?
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = transaction.errors.full_messages.to_sentence
      render action
    end
  end

  def sort_column
    %w[amount transaction_type created_at].include?(params[:sort_column]) ? params[:sort_column] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:sort_direction]) ? params[:sort_direction] : 'desc'
  end
end
