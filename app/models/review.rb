class Review < ApplicationRecord
  belongs_to :book

  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5, message: "should be between 1 and 5" }
end
