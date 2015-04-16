class AddGeometryInfoToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :country_code, :string
    add_column :trips, :vp_ne_lat, :float
    add_column :trips, :vp_ne_lng, :float
    add_column :trips, :vp_sw_lat, :float
    add_column :trips, :vp_sw_lng, :float
  end
end
