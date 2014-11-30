class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:start, :update, :show]


  def create
     @trip = Trip.create(query: params[:q])
     redirect_to start_trip_path(@trip)
  end

  def start

  end

  def update
    @trip.update(user_id: current_user.id)
    order_hash = JSON.parse(params[:order])
    update_trip_experience_order(order_hash)
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

  def orders

  end

  private


  def set_trip
    @trip = Trip.find(params[:id])
  end

  def update_trip_experience_order(order_hash)
    order_hash.each do |k, v|
      TripExperience.find(v.to_i).update(order: k.to_i)
    end
  end

end
