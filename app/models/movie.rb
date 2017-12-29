class Movie < ApplicationRecord

	mount_uploader :image, MovieUploader
	validates_presence_of :title, :genre, :plot, :image, :rating, :web, :cast
   
    has_many :reviews, dependent: :destroy
    has_many :impressions, dependent: :destroy


    def self.search(search)
  	 	where("title LIKE ?", "%#{search}%") 
	end

end
