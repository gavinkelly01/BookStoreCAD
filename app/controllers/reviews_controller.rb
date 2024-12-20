class ReviewsController < ApplicationController
  before_action :set_book, only: [:create, :index]

  def index
    # Fetch all reviews for the specific book
    @reviews = @book.reviews
    render json: @reviews
  end

  def create
    # Ensure that user_id is assigned to the review
    # Assuming you store the logged-in user's ID in the session (e.g., session[:user_id])
    if session[:user_id].present?
      @review = @book.reviews.build(review_params.merge(user_id: session[:user_id]))
      
      if @review.save
        render json: @review, status: :created
      else
        render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'You must be logged in to leave a review.' }, status: :unauthorized
    end
  end

  private

  def set_book
    @book = Book.find_by(id: params[:book_id])
    unless @book
      render json: { error: 'Book not found' }, status: :not_found
    end
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
