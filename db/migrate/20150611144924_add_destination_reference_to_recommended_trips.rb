class AddDestinationReferenceToRecommendedTrips < ActiveRecord::Migration
  def change
    add_reference :recommended_trips, :destination, index: true
  end
end
