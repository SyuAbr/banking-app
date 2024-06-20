class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[edit update destroy more]
  def new
    @bank_account = current_client.bank_accounts.build
  end

  def edit
    @bank_account = current_client.bank_accounts.find(params[:id])
  end

  def create
    @bank_account = current_client.bank_accounts.build(bank_account_params)
    @bank_account.account_number = generate_account_number
    @bank_account.balance = 10_000
    if @bank_account.save
      redirect_to current_client
    else
      render :new
    end
  end

  def more
    @bank_account = current_client.bank_accounts.find(params[:id])
  end

  def update
    @bank_account = current_client.bank_accounts.find(params[:id])
    if @bank_account.update(bank_account_params)
      redirect_to current_client
    else
      render :edit
    end
  end

  def destroy
    @bank_account.destroy!
    redirect_to current_client
  end

  def restore
    @bank_account = current_client.bank_accounts.with_deleted.find(params[:id])
    @bank_account.restore!
    redirect_to deleted_client_bank_accounts_path(client_id: current_client.id)
  end

  private

  def set_bank_account
    @bank_account = current_client.bank_accounts.without_deleted.find(params[:id])
  end

  def deleted
    @deleted_bank_accounts = current_client.bank_accounts.only_deleted
  end

  def bank_account_params
    params.require(:bank_account).permit(:account_type)
  end

  def generate_account_number
    loop do
      account_number = rand(10**9)
      return account_number unless BankAccount.exists?(account_number: account_number)
    end
  end
end
