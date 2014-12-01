class AddQueryToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :query, :string
  end
end
