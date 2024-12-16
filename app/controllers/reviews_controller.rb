class ReviewsController < ApplicationController
  before_action :set_book, only: [:create]

def create
  @review = @book.reviews.build(review_params)
  @review.user_id = current_user.id if user_signed_in?

  if @review.save
    render json: @review, status: :created
  else
    # Log the error to the console or response for debugging
    Rails.logger.error "Review creation failed: #{@review.errors.full_messages.join(', ')}"
    render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
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
    # Allow content and rating in the review params
    params.require(:review).permit(:content, :rating)
  end
end
