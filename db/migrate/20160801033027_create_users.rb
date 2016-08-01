class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :phone
      t.string :address
      t.boolean :sex
      t.boolean :is_admin
      t.string :password_digest
      t.string :remember_token

      t.timestamps null: false
    end
    add_index :users, :name, unique: true
    add_index :users, :email, unique: true
  end
end
