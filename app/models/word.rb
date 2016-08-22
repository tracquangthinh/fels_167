class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}
  has_many :results
  validates :content, presence: true, length: {maximum: 45}
  after_initialize :build_word_answers

  private
  def build_word_answers
    if self.new_record? && self.word_answers.size == 0
      Settings.default_size_word_answers.times {self.word_answers.build}
    end
  end
end
