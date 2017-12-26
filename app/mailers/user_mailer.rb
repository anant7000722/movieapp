class UserMailer < ApplicationMailer
default from: "railscasts@example.com"
 
  def signup_confirmation(user)
    @user = user
    debugger

    mail to: user.email, subject: "Sign Up Confirmation"
  end
end
