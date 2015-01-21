class RenameCoordinatesToTrip < ActiveRecord::Migration
  def change
    rename_column :trips, :query_lat, :latitude
    rename_column :trips, :query_lng, :longitude
  end
end
