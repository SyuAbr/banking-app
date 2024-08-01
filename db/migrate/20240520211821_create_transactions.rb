class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :transaction_type
      t.references :sender,  foreign_key: { to_table: :bank_accounts  }
      t.references :recipient, foreign_key: { to_table: :bank_accounts }, null: true
      t.text :comment

      t.timestamps
    end
  end
end
