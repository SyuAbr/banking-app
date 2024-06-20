class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
