class AddBankAccountIdToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :bank_account, null: false, foreign_key: true
  end
end
