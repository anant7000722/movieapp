ActiveAdmin.register User do
	  decorate_with UserDecorator

index do
    selectable_column
    id_column
    column :email
    column :u_image
    column :name
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

end
