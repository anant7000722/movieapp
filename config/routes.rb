Rails.application.routes.draw do
  match '/admin/movies' => 'movies#create', via: :post
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  	get "movies/moviesbynav" 
  
  	devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks" }
    # as :user do
    #get 'login' => 'sessions#new', :as => "login"
    #get 'signup' => 'registrations#new', :as => "signup"  
    #get 'signout' => 'devise/sessions#destroy', :as => "signout"
#end
  	
	resources :movies do
		resources :reviews, except: [:show, :index]
  	end
  root 'movies#index'

end
