class AddAddedToTripToTripComments < ActiveRecord::Migration
  def change
    add_column :trip_comments, :add_to_trip, :boolean, default: false
  end
end
