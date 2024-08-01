class BankAccount < ApplicationRecord
  acts_as_paranoid
  belongs_to :client
  has_many :transactions, dependent: :destroy

  after_initialize :set_default_balance, if: :new_record?

  after_destroy_commit -> { broadcast_remove_to self}
  after_update_commit -> {broadcast_replace_to [self, client],  partial: 'bank_accounts/account', locals: {account: self, current_client: client}}
  after_create_commit -> {broadcast_append_to 'bank', target: 'bank_acc',  partial: 'bank_accounts/account', locals: {account: self, current_client: client}}


  def generate_account_number
    loop do
      account_number = rand(10**9)
      return account_number unless BankAccount.exists?(account_number: account_number)
    end
  end

  private

  def set_default_balance
    self.balance ||= 10_000
  end
end
