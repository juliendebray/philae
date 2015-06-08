class RecommendedTripsController < ApplicationController
  before_action :authenticate_user!

  def add_to_trip
    @trip = Trip.find(params[:trip_id])
    @recommended_trip = RecommendedTrip.find(params[:recommended_trip_id])
    raise
  end
end
