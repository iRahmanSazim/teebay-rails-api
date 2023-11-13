class Product < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 255 }
  validate :valid_user_id

  private

  def valid_user_id
    errors.add(:user, 'must reference a valid user') unless User.exists?(id: user_id)
  end
end
