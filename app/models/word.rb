class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers
  has_many :results
end
