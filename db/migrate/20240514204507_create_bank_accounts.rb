class CreateBankAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_accounts do |t|
      t.integer :account_number
      t.string :account_type
      t.decimal :balance
      t.belongs_to :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
