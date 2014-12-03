class TripsController < ApplicationController
  before_action :authenticate_guest!, only: [:show_guest_user]
  before_action :authenticate_user!, except: [:create, :start]
  before_action :set_trip, only: [:start, :update, :show, :show_guest_user, :share_trip_email]

  def has_current_guest
    @current_guest
  end

  def create
    @trip = Trip.new(query: params[:q])
    @trip.query_lat = params[:latitude]
    @trip.query_lng = params[:longitude]
    @trip.title = "#{params[:q]}"
    @trip.save

    redirect_to start_trip_path(@trip)
  end

  def start
    @trip = Trip.find(params[:id])
    if @trip.user
      redirect_to @trip
    else
      if TripExperience.find_by(trip_id: params[:id])
        @trip_exp_tab = @trip.trip_experiences.sort_by do |te|
          te.order
        end
      end
      render :show
    end
  end

  def update
    @trip.update(user_id: current_user.id)
    order_hash = JSON.parse(params[:order])
    update_trip_experience_order(order_hash)

    redirect_to trip_path(@trip)
  end

  def show
    @trip = current_user.trips.find(params[:id])
    @trip_exp_tab = @trip.trip_experiences.sort_by do |te|
      te.order
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to user_path(current_user)
  end

  def show_guest_user
  end

  def share_trip_email
    current_user.send_trip_email(@trip)
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

  def authenticate_guest!
    @trip = Trip.find(params[:id])
    @guest_user = true if @trip.token == params[:token]
  end
end
