class CreateAuthTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_tokens, id: :uuid do |t|
      t.datetime :expires_at, null: false
      t.uuid :user_id, null: false
      t.string :value, null: false
      t.timestamps
    end

    add_index :auth_tokens, :expires_at
    add_index :auth_tokens, :user_id
    add_index :auth_tokens, :value
  end
end
