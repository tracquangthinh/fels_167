class ChangeUniqueToLessons < ActiveRecord::Migration
  def change
    remove_index :lessons, [:user_id, :category_id]
    add_index :lessons, [:user_id, :category_id]
  end
end
