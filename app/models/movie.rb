class Movie < ApplicationRecord

	mount_uploader :image, MovieUploader
	validates_presence_of :title, :genre, :plot, :image, :rating, :web, :cast
   
    has_many :reviews
    has_many :impressions

end
