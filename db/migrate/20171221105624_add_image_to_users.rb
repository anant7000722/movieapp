class AddImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :u_image, :string
  end
end
