class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
     def after_sign_in_path_for(resource)
        movies_path
      end
     def after_sign_out_path_for(resource)
         new_user_session_path
     end

    protected
 	def configure_permitted_parameters
   		devise_parameter_sanitizer.permit(:sign_up, keys: [:u_image])
   		devise_parameter_sanitizer.permit(:account_update, keys: [:u_image])
 	end
 

end
