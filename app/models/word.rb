class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answer
  has_many :result
end
