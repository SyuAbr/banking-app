class AddPasswordResetTokenAndPasswordResetTokenSentAtToClient < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :password_reset_token, :string
    add_index :clients, :password_reset_token
    add_column :clients, :password_reset_token_sent_at, :datetime
  end
end
