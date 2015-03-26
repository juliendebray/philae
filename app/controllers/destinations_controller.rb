class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :must_see]

  def index
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.find(params[:id])
    end

end

