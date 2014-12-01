class AddQueryLngToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :query_lng, :float
  end
end
