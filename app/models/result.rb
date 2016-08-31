class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer
  after_validation :check_correct

  protected
  def check_correct
    @word_answer = WordAnswer.find_by id: self.word_answer_id
    @correct = @word_answer.nil? ? false : @word_answer.is_correct
    self.is_correct = @correct
  end
end
