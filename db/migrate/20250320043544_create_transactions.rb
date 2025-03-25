class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :amount, null: false, precision: 15, scale: 2
      t.string :transaction_type, null: false

      t.timestamps
    end
  end
end
