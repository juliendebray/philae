class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :must_see]

  def index
  end

  def show
  end

  def show_within_trip
    @destination = Destination.find(params[:destination_id])
    @trip = Trip.find(params[:trip_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.find(params[:id])
    end
end