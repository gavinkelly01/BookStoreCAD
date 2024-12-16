class Book < ApplicationRecord
 has_many :reviews, dependent: :destroy
    has_one_attached :image
    validates :title, :author, :price, presence: true
    scope :filter_by_title, ->(title) { where('lower(title) LIKE ?', "%#{title.downcase}%") }
    scope :filter_by_author, ->(author) { where('lower(author) LIKE ?', "%#{author.downcase}%") }
  end
  
