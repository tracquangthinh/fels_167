class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :category_id
      t.references :user, index: true, foreign_key: true
      t.boolean :is_completed

      t.timestamps null: false
    end
    add_index :lessons, [:user_id, :category_id], unique: true
  end
end
