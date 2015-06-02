class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :must_see]

  def index
    @destination = Destination.all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.find(params[:id])
    end

    def destination_params
      params.require(:destination).permit(:name, destination_pictures_attributes: [:picture])
    end

end

