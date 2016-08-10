class ChangeDefaultIsCorrectWordAnswers < ActiveRecord::Migration
  def change
    change_column :word_answers, :is_correct, :boolean, default: false
  end
end
