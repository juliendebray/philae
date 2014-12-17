class AskYourFriendsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @trip = Trip.find(params[:trip_id])
  end
end
