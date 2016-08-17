class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words, dependent: :destroy
  scope :previous, ->(id) {where("id < ?", id).last}
  scope :next, ->(id) {where("id > ?", id).first}
  validates :name, presence: true, length: {maximum: 45}, uniqueness: true
  validates :description, presence: true, length: {maximum: 255}
end
