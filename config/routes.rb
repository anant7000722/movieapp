Rails.application.routes.draw do
  	get "movies/moviesbynav" 
  
  	devise_for :users
  	
	resources :movies do
		resources :reviews, except: [:show, :index]
  	end
  root 'movies#index'

end
