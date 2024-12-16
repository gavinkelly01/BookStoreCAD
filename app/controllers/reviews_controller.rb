# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :set_book

  def index
    # Fetch all reviews for the specified book
    @reviews = @book.reviews
    render json: @reviews
  end

  def create
    # Create a new review for the specified book
    @review = @book.reviews.new(review_params)
    if @review.save
      render json: @review, status: :created
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find_by(id: params[:book_id])
    render json: { error: 'Book not found' }, status: :not_found if @book.nil?
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

