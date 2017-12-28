class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :u_image, UserUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :omniauthable
         has_many :reviews, dependent: :destroy
  

def self.from_omniauth(auth, signed_in_resource = nil)
 
  user = User.where(provider: auth.provider, uid: auth.uid).first
  if user.present?
    user
  else
    # Check wether theres is already a user with the same 
    # email address
    user_with_email = User.find_by_email(auth.info.email)
    if user_with_email.present?
      user = user_with_email
    else
        user = User.new
        if auth.provider == "facebook"
        
          user.provider = auth.provider
          user.uid = auth.uid
         
          
         
          user.email = auth.extra.raw_info.email
          # Facebook's token doesn't last forever
    
        user.save
      elsif auth.provider == "linkedin" 
      
        user.provider = auth.provider
        user.uid = auth.uid
          user.oauth_token = auth.credentials.token
          
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.email = auth.info.email
      
        user.save
      elsif auth.provider == "twitter" 
        
          user.provider = auth.provider
        user.uid = auth.uid
          user.oauth_token = auth.credentials.token
          
          user.oauth_user_name = auth.extra.raw_info.name
           
           elsif auth.provider == "github"         
          
          user.provider = auth["provider"]
            user.uid = auth["uid"]
 
            user.oauth_user_name = auth["info"]["name"]            
         user.email = auth["info"]["email"]
         user.save
           elsif auth.provider == "google_oauth2"
             
             user.provider = auth.provider
        user.uid = auth.uid
          user.oauth_token = auth.credentials.token
          
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.email = auth.info.email
          # Google's token doesn't last forever
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save
           end
    end    
  end
  return user
  end
  # For Twitter (save the session eventhough we redirect user to registration page first)
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end  
  end  
  # For Twitter (disable password validation)
  def password_required?
    super && provider.blank?
  end  

end
