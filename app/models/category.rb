class Category < ActiveRecord::Base
  has_many :lesson
  has_many :word
end
