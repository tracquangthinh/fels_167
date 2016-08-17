class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :result
  accepts_nested_attributes_for :result
end
