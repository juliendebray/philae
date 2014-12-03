class TripCommentsController < ApplicationController
  before_action :set_trip, only: [:create]

  def create
    @trip_comment = @trip.trip_comments.create(trip_comments_params)
  end

  def destroy
    @trip_comment = TripComment.find(params[:id])
    @trip_comment.destroy
  end

  private
  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def trip_comments_params
    params.require(:trip_comment).permit(:name, :address, :description)
  end
end
