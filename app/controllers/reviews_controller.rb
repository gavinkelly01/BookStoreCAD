class ReviewsController < ApplicationController
  before_action :set_book, only: [:create]

  # POST /books/:book_id/reviews
  def create
    @review = @book.reviews.new(review_params)
    if @review.save
      render json: @review, status: :created
    else
      # Log the errors to help debug
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
    # Ensure that we permit the 'content' and 'rating' within the 'review' key
    params.require(:review).permit(:content, :rating)
  end
end
