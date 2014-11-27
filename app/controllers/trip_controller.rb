class TripController < ApplicationController
  before_action :find_trip

  def index
    # lister les trips
  end

  def new
    #creer un nouveau trip
    @user = current_user
    @trip = @user.trips.new(trip_params)
  #   @user = current_user
  #   if @user
  #     @trip = @user.trips.new
  #   else
  #     redirect_to root_path
  #   end
  # end

  end

  def create
    #creer un nouveau
    trip = @trip.new(user_id:current_user.id)
    trip.save
    redirect_to trip_path(@trip)
  end

  def show
    #aller sur la page d'un trip
  end

  def edit
    #Modifier l'itinéraire
  end

  def destroy
    #sur la liste des trips
  end

  private

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

end
