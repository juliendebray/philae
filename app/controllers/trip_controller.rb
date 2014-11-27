class TripController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip_from_session, only: [:update]

  def update
    @trip.user_id = current_user.id
    @trip.save
    render :show
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

end
