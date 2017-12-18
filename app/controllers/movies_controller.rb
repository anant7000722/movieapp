class MoviesController < ApplicationController

	before_action :set_id,except:[:new,:create,:index]

	def index
		@movies = Movie.all
		@movies_sorted = @movies.order('rating DESC')
	end

	def new
		 @movies = Movie.new
	end

	def create
		@movies =  Movie.new(movie_params)
     if @movies.save
      redirect_to @movies,notice: "movie Successfully Saved"
     else
       render 'new'
     end
	end

	def show
		@movies1 = Movie.all
		@movies_sorted = @movies1.order('rating DESC')
		
		@reviews = Review.where(movie_id: @movies.id).order("created_at DESC")
	
	end


	def editM
	end

	def update
	end


	def destroy
	end

	 private
   def movie_params
     params.require(:movie).permit(:title,:image,:genre,:plot,:rating,:web, :year, :cast)
   end
 
   def set_id
     @movies = Movie.find(params[:id])
  end


end
