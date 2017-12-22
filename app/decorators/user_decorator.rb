class UserDecorator < Draper::Decorator
 delegate_all
 def u_image
   
    if model.u_image_url.present?
      h.image_tag(model.u_image_url, width: "50px",height: "50px")
    else
    end
  end
end
