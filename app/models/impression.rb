class Impression < ApplicationRecord
	belongs_to :movie, counter_cache: :impression_count
end
