class MoviesController < ApplicationController
	before_action :set_id, except:[:new,:create,:index,:show,:moviesbynav]


	def index
	    if params[:search].present?
	      @movies = Movie.where(['title like ?', "%"+params[:search]+"%"])
	    else
	      @movies = Movie.all
	    end
		@movies_sorted = @movies.order('rating DESC').limit(4)
    	@movies_viewed = @movies.order('impression_count DESC').limit(4)
    end

    def moviesbynav

    	 if params[:search].present?
	      @movies = Movie.where(['title like ?', "%"+params[:search]+"%"])
	    else
	      @movies = Movie.all
	    end
		@movies_sorted = @movies.order('rating DESC')
    	@movies_viewed = @movies.order('impression_count DESC')

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
    	@movies = Movie.find(params[:id])
    
    	@i = Impression.create(movie_id: @movies.id)
  		@movies_sorted = @movies1.order('rating DESC')

		@reviews = Review.where(movie_id: @movies.id).order("created_at DESC")
	end

	private
    def movie_params
  	 params.require(:movie).permit(:title,:image,:genre,:plot,:rating,:web, :year, :cast)
    end
 
  	def set_id
   		@movies = Movie.find(params[:id])
  	end


end
