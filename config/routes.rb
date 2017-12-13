Rails.application.routes.draw do
	resources :movies
  root 'home#index'
  
end
