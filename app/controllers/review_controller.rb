class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:show, :update, :destroy]

  # GET /books/:book_id/reviews
  def index
    @reviews = @book.reviews
    render json: @reviews
  end

  # GET /books/:book_id/reviews/:id
  def show
    render json: @review
  end

  # POST /books/:book_id/reviews
  def create
    @review = @book.reviews.new(review_params)
    @review.user = current_user # Assuming you're using a `current_user` helper for authentication

    if @review.save
      render json: @review, status: :created
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/:book_id/reviews/:id
  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /books/:book_id/reviews/:id
  def destroy
    @review.destroy
    head :no_content
  end

  private

  # Set the book based on the book_id in the URL
  def set_book
    @book = Book.find(params[:book_id])
  end

  # Set the review based on the id in the URL
  def set_review
    @review = @book.reviews.find(params[:id])
  end

  # Strong parameters to ensure only the required fields are allowed
  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
