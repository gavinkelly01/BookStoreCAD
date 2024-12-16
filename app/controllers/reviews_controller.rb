class ReviewsController < ApplicationController
  before_action :set_book, only: [:create]

  def create
    @review = @book.reviews.build(review_params)
    if @review.save
      render json: @review, status: :created
    else
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
    params.require(:review).permit(:content, :rating)
  end
end
