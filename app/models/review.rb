class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :content, :rating, presence: true
end

