class MoviesController < ApplicationController
	before_action :set_id, except:[:new,:create,:index,:show,:moviesbynav]


	def index
		
		search = params[:search]
	    if params[:search].present?
	      @movies = Movie.where("title like? OR title like? OR title like? OR title like?","%#{search.capitalize}%","%#{search.downcase}%","%#{search.upcase}%",
	      	"%#{search.titleize}%")
	    else
	      @movies = Movie.all
	    end

		@movies_sorted = @movies.order('rating DESC').limit(4)
    	@movies_viewed = @movies.order('impression_count DESC').limit(4)
    end

    def moviesbynav
    
    	search = params[:search]
		if params[:search].present?
	      @movies = Movie.where("title like? OR title like? OR title like? OR title like?","%#{search.capitalize}%","%#{search.downcase}%","%#{search.upcase}%",
	      	"%#{search.titleize}%")
	    else
	      @movies = Movie.all
	    end
		@movies_sorted = @movies.order('rating DESC')
    	@movies_viewed = @movies.order('impression_count DESC')

    end

	def create
		
		if params[:view] == "automatic"
			@call = AnotherServiceCall.new.api_call(params[:movie][:title])
			
			if @call == true
				redirect_to "#{ Rails.application.secrets.url}/admin/movies", notice: "Successfully Saved"
			else
				redirect_to new_admin_movie_path(view: params[:view]), alert: "No movie found"
			end
		else

			@movies =  Movie.new(movie_params)
			if @movies.save
			   redirect_to @movies,notice: "movie Successfully Saved"
			else
			   render 'new'
			end
		end
	end

	def show
		
		@movies1 = Movie.all
    	@movies = Movie.find(params[:id])
    	@i = Impression.create(movie_id: @movies.id)
		@movies_sorted = @movies1.order('rating DESC')
		

		if user_signed_in?
			@img = current_user.u_image_url
	    else
	    end
			@user = User.all

			@reviews = Review.where(movie_id: @movies.id).order("created_at DESC").limit(2)
			@reviews_for_modal = Review.where(movie_id: @movies.id).order("created_at DESC")
	end

	private
    def movie_params
    	
  	 	params.require(:movie).permit(:title,:image,:genre,:plot,:rating,:web, :year, :cast)
    end
 
  	def set_id
  		
   		@movies = Movie.find(params[:id])
  	end


end
