class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:start, :update, :show]


  def create
     @trip = Trip.create  # TODO: store query?
     redirect_to start_trip_path(@trip)
  end

  def start

  end

  def update
    @trip.update(user_id: current_user.id)
    redirect_to trip_path(@trip)
  end

  def show
  end

  def edit
    #Modifier l'itinéraire
  end

  def destroy
    #sur la liste des trips
  end

  private


  def set_trip
    @trip = Trip.find(params[:id])
  end


end
