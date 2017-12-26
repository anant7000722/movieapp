Rails.application.routes.draw do
  match '/admin/movies' => 'movies#create', via: :post
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  	get "movies/moviesbynav" 
  
  	devise_for :users
  	
	resources :movies do
		resources :reviews, except: [:show, :index]
  	end
  root 'movies#index'

end
