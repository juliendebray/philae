class AddRecommendedTripReferenceToTripExperience < ActiveRecord::Migration
  def change
    add_reference :trip_experiences, :recommended_trip, index: true
  end
end
