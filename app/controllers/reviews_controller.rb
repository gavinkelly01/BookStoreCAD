# app/controllers/reviews_controller.rb

class ReviewsController < ApplicationController
  before_action :set_book, only: [:create]

  def create
    @review = @book.reviews.new(review_params)
    if @review.save
      render json: @review, status: :created
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Book not found' }, status: :not_found
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
