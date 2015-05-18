class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.datetime :expires_at, null: false
      t.integer :user_id, null: false
      t.string :value, null: false

      t.timestamps null: false
    end

    add_index :auth_tokens, [:user_id, :value]
  end
end
