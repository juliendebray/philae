class TripController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:update, :show]

  def update
    @trip.update(user_id: current_user.id)
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

  def set_trip_from_session
    @trip = Trip.find(session[:trip_id])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end


end
