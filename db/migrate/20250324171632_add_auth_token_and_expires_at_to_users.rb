class AddAuthTokenAndExpiresAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :token, :string
    add_column :users, :expires_at, :datetime
  end
end
