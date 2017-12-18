class AddCounterCacheToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :impression_count, :integer
  end
end
