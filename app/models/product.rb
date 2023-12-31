class Product < ApplicationRecord
  belongs_to :user
  has_many :conversations

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 255 }
end
