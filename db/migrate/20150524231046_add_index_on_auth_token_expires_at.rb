class AddIndexOnAuthTokenExpiresAt < ActiveRecord::Migration
  def change
    add_index :auth_tokens, :expires_at
  end
end
