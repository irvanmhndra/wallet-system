class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :owner, polymorphic: true, null: false
      t.decimal :balance, default: 0, precision: 15, scale: 2

      t.timestamps
    end
  end
end
