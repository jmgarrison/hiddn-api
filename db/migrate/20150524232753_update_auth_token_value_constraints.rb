class UpdateAuthTokenValueConstraints < ActiveRecord::Migration
  def up
    remove_index :auth_tokens, column: [:user_id, :value]
    add_index :auth_tokens, [:user_id, :value], unique: true
    add_index :auth_tokens, :value, unique: true
  end

  def down
    remove_index :auth_tokens, column: [:user_id, :value]
    add_index :auth_tokens, [:user_id, :value]
    remove_index :auth_tokens, :value
  end
end
