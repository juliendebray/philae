class AddDestinationToTrip < ActiveRecord::Migration
  def change
    add_reference :trips, :destination, index: true
  end
end
