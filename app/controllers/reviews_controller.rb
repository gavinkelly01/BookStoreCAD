class ReviewsController < ApplicationController
  before_action :set_book, only: [:index, :create]

  # GET /books/:book_id/reviews
  def index
    @reviews = @book.reviews
    render json: @reviews
  end

  # POST /books/:book_id/reviews
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
    @book = Book.find_by(id: params[:book_id])
    render json: { error: 'Book not found' }, status: :not_found if @book.nil?
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

