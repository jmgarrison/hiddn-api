class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences, id: :uuid do |t|
      t.hstore :types, null: false
      t.decimal :min_rating, null: false
      t.uuid :user_id, null: false
      t.string :session_uuid
      t.timestamps null: false
    end

    add_index :user_preferences, :user_id
  end
end
