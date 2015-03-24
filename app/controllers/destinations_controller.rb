class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show]
  def index
    @trip = Trip.new
  end

  def show

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.find(params[:id])
    end

end

