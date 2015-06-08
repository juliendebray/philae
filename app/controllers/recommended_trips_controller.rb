class RecommendedTripsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def add_to_trip
    @trip = Trip.find(params[:trip_id])
    @recommended_trip = RecommendedTrip.find(params[:recommended_trip_id])
    order = @trip.trip_experiences.count + 1
    @recommended_trip.recommended_trip_experiences.each do |rte|
      @trip.trip_experiences.create(recommended_trip_id: @recommended_trip.id, experience_id: rte.experience.id, order: rte.order + order)
    end
    raise
  end
end
