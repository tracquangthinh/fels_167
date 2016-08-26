class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results
  accepts_nested_attributes_for :results,
    reject_if: proc{|attributes| attributes["word_answer_id"].blank?}
  after_create :create_data
  validate :check_word

  protected
  def check_word
    @words = self.category.words.take Settings.take_num_lesson
    if @words.count < Settings.take_num_lesson
      errors.add :not_enough_word, I18n.t(:not_enough_word)
    end
  end

  def create_data
    @words = self.category.words.shuffle.take Settings.take_num_lesson
    @words.each do |word|
      self.results.create(word_id: word.id, word_answer_id: 0, is_correct: false)
    end
  end
end
