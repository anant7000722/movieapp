class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :authenticate_user!
 
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.movie_id = @movie.id

      if @review.save
       redirect_to  @movie
      else
        redirect_to  @movie,alert: "Review Cannot Be Saved"
      end
    
  end

  private
    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_params
      params.require(:review).permit(:comment)
    end
  end
