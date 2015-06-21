class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false, uniqueness: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
    end

    add_index :users, :email
  end
end
