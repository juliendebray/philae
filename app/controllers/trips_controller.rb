class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:create, :start]
  before_action :set_trip, only: [:start, :update, :show]


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

  def edit
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to user_path(current_user)
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

  def trip_params
  end


end
