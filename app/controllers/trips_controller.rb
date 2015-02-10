class TripsController < ApplicationController
  before_action :authenticate_guest!, only: [:show_guest_user]
  before_action :authenticate_user!, except: [:create, :start, :show_guest_user, :notification_for_sharing_email, :providers, :summarize]
  before_action :set_trip, only: [:start, :update, :show, :show_guest_user, :share_trip_email, :notification_for_sharing_email, :providers, :summarize, :update_order, :send_my_trip_email]

  def create
    if params[:trip].nil?
      @trip = Trip.new(query: 'Maroc without query', latitude: 31.943808, longitude: -6.271945)
      @trip.title = 'Morocco'
    elsif params[:trip][:query]
      @trip = Trip.new(trip_params)
      @trip.title = @trip.query
    end
    @trip.save
    redirect_to start_trip_path(@trip)
  end

  def start
    @trip = Trip.find(params[:id])
    if current_user
      @trip.update(user_id: current_user.id) unless @trip.user
      redirect_to @trip
    elsif @trip.user
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
    if params[:order]
      order_hash = JSON.parse(params[:order])
      update_trip_experience_order(order_hash)
    end
    flash[:sucess] = 'Voyage sauvegardé!'
    redirect_to trip_path(@trip)
  end

  def update_order
    if params[:order]
      order_hash = params[:order]
      update_trip_experience_order(order_hash)
    end
  end

  def show
    @guest_user = false
    @trip = current_user.trips.find(params[:id])
    set_orders_if_nil!(@trip.trip_experiences)
    @trip_exp_tab = @trip.trip_experiences.sort_by do |te|
      te.order
    end
  end

  def summarize
    set_orders_if_nil!(@trip.trip_experiences)
    @trip_exp_ordered = @trip.trip_experiences.sort_by do |te|
      te.order
    end
  end

  def show_guest_user
    if params[:token] == @trip.token
      @guest_user = true
      @trip_exp_tab = @trip.trip_experiences.sort_by do |te|
        te.order
      end
    else
      render "public/422.html"
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to user_path(current_user)
  end

  def share_trip_email
    current_user.send_trip_email(@trip)
    flash[:sucess] = 'Un email vous a été envoyé avec le lien vers votre voyage.'
    redirect_to trip_ask_your_friends_path(@trip)
  end

  def notification_for_sharing_email
    @trip.user.send_notif_email(@trip)
  end

  def send_my_trip_email
    current_user.send_trip_summary_email(@trip)
  end

  def providers
  end

  private

  def trip_params
    params.require(:trip).permit(:query, :latitude, :longitude)
  end

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

  def set_orders_if_nil!(trip_experiences)
    trip_experiences.map do |trip_exp|
      count = trip_experiences.reject {|te| te.order.nil?}.size
      trip_exp.order = count + 1 if trip_exp.order.nil?
    end
  end
end
