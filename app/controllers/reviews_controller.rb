class ReviewsController < ApplicationController
  before_action :set_book

  def index
    @reviews = @book.reviews
    render json: @reviews
  end

  # Other actions follow the same pattern
  
  private

  def set_book
    @book = Book.find(params[:book_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Book not found" }, status: :not_found
  end
end
