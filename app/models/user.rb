class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :u_image, UserUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :reviews, dependent: :destroy
		after_create :send_admin_mail
  def send_admin_mail
   UserMailer.signup_confirmation(self).deliver_now
  
  end
end
