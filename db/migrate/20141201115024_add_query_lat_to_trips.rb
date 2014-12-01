class AddQueryLatToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :query_lat, :float
  end
end
