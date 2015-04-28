class TripsController < ApplicationController
  before_action :authenticate_guest!, only: [:show_guest_user]
  before_action :authenticate_user!, except: [:update_order, :create, :start, :show_guest_user, :notification_for_sharing_email, :providers]
  before_action :set_trip, only: [:start, :update, :show, :show_guest_user, :share_trip_email, :notification_for_sharing_email, :providers, :summarize, :update_order, :send_my_trip_email, :demo, :selection_display, :explore_map]
  respond_to :js, only: [:selection_display, :share_trip_email]

  def create
    @trip = current_user.trips.new(trip_params)
    @trip.title = @trip.query
    destination = Destination.find_by(country_code: @trip.country_code)
    @trip.destination = destination
    @trip.save
    destination ? path = user_trip_path(current_user, @trip) : path = start_trip_path(@trip)
    redirect_to path
    # Libanese demo
    # if params[:title] && params[:title] == 'Liban'
    #   authenticate_user!
    #   @destination = Destination.first
    #   @trip = current_user.trips.create(query: @destination.name, title: @destination.name, latitude: 33.89120770946144, longitude: 35.88151107421868)
    #   redirect_to demo_trip_path(@trip)
    # else
    # # TODO: change Morocco default behavior
    #   if params[:trip].nil?
    #     @trip = Trip.new(query: 'Maroc without query', latitude: 31.943808, longitude: -6.271945)
    #     @trip.title = 'Morocco'
    #   elsif params[:trip][:query]
    #     @trip = Trip.new(trip_params)
    #     @trip.title = @trip.query
    #   end
    #   @trip.save
    #   redirect_to start_trip_path(@trip)
    # end
  end

  def start
    @trip = Trip.find(params[:id])
    # if current_user
    #   @trip.update(user_id: current_user.id) unless @trip.user
    #   redirect_to @trip
    # elsif @trip.user
    #   redirect_to @trip
    # else
      if TripExperience.find_by(trip_id: params[:id])
        @trip_exp_tab = @trip.trip_experiences.sort_by do |te|
          te.order
        end
      end
      # render :show
    # end
  end

  def explore_map
    bounding_box = []
    if @trip.viewport_set?
      bounding_box[0] = @trip.vp_sw_lat
      bounding_box[1] = @trip.vp_sw_lng
      bounding_box[2] = @trip.vp_ne_lat
      bounding_box[3] = @trip.vp_ne_lng
    elsif destination = @trip.destination
      bounding_box[0] = destination.sw_lat
      bounding_box[1] = destination.sw_lng
      bounding_box[2] = destination.ne_lat
      bounding_box[3] = destination.ne_lng
    else
      distance = 150
      center_point = [@trip.latitude, @trip.longitude]
      bounding_box = Geocoder::Calculations.bounding_box(center_point, distance)
    end
    experiences_within_bounds = Experience.where(published: true).within_bounding_box(bounding_box)
    @markers = build_markers(experiences_within_bounds.sort_by{|e| e.average_rating}.reverse, @trip, true)
    raise
  end

  def show
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


  # Lebanes demo
  def selection_display
    @destination = Destination.first
  end

  # Libanese demo
  def demo
    @destination = Destination.first
    @trip = Trip.find(params[:id])
    @guest_user = false
    @trip_exp_tab = @trip.trip_experiences.sort_by do |te|
      te.order
    end
  end

  def summarize
    # set_orders_if_nil!(@trip.trip_experiences)
    @trip_exp_ordered = @trip.trip_experiences.sort_by do |te|
      te.order
    end
  end

  def show_guest_user
    if params[:token] == @trip.token
      @guest_user = true
      trip_experiences =  @trip.trip_experiences
      trip_exp_tab_all = trip_experiences.sort_by do |te|
        te.order
      end
      @trip_exp_tab = trip_exp_tab_all.reject { |te| te.experience.from_guest_comment == true }
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
    # flash[:sucess] = 'Un email vous a été envoyé avec le lien vers votre voyage.'
    # redirect_to trip_ask_your_friends_path(@trip)
    # redirect_to session[:previous_url]
  end

  def notification_for_sharing_email
    @trip.user.send_notif_email(@trip)
    # TODO: check if hidden field in the form_for is really necessary
  end

  def send_my_trip_email
    current_user.send_trip_summary_email(@trip)
    flash[:sucess] = 'Un email vous a été envoyé avec le résumé de votre voyage.'
    redirect_to summarize_trip_path(@trip)
    # TODO: redirect to js to change the class of the button
    # TODO: check if hidden field in the form_for is really necessary
  end

  def providers
  end

  private

  def trip_params
    params.require(:trip).permit(
      :query,
      :latitude,
      :longitude,
      :picture,
      :country_code,
      :vp_ne_lat,
      :vp_ne_lng,
      :vp_sw_lat,
      :vp_sw_lng,
      :title
    )
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

  def build_markers(experiences, trip, experience_block_required)
    Gmaps4rails.build_markers(experiences) do |experience, marker|
      marker.lat experience.latitude
      marker.lng experience.longitude
      marker.title experience.name
      trip_experiences = TripExperience.where("trip_id = ? AND experience_id = ?", trip.id, experience.id)
      if trip_experiences.any?
        # experience.must_see ? picture_url = "https://philae-floju.s3.amazonaws.com/markers/selection_must_see.png" : picture_url = "https://philae-floju.s3.amazonaws.com/markers/selection.png"
        marker.picture({
        url: "https://philae-floju.s3.amazonaws.com/markers/selection.png",
        width:  25,
        height: 39
        })
        if experience_block_required
          marker.json({
            infobox:  render_to_string(partial: "/trip_experiences/infowindow.html.erb", locals: {
              experience: experience,
              trip: trip,
              trip_experience: trip_experiences.first,
              guest_user: false
            }),
            experience_id: experience.id,
            experience_block: render_to_string(partial: "/trip_experiences/experience_block.html.erb", locals: {
              trip_exp: trip_experiences.first,
              guest_user: false,
              experience: experience,
              trip: trip
            })
          })
        else
          marker.json({
            infobox:  render_to_string(partial: "/trip_experiences/infowindow.html.erb", locals: {
              experience: experience,
              trip: trip,
              trip_experience: trip_experiences.first,
              guest_user: false
            }),
            experience_id: experience.id
          })
        end
      else
        # experience.must_see ? picture_url = "https://philae-floju.s3.amazonaws.com/markers/top_must_see.png" : picture_url = "https://philae-floju.s3.amazonaws.com/markers/top.png"
        experience.must_see ? picture_url = "https://philae-floju.s3.amazonaws.com/markers/top_must_see.png" : picture_url = "https://philae-floju.s3.amazonaws.com/markers/top_2.png"
        marker.picture({
          url: picture_url,
          width:  25,
          height: 39
        })
        if experience_block_required
          marker.json({
            infobox:  render_to_string(partial: "/trip_experiences/infowindow.html.erb", locals: {
              experience: experience,
              trip: trip,
              trip_experience: false,
              guest_user: false
            }),
            experience_id: experience.id,
            experience_block: render_to_string(partial: "/trip_experiences/experience_block.html.erb", locals: {
              trip_exp: false,
              guest_user: false,
              experience: experience,
              trip: trip
            })
          })
        else
          marker.json({
            infobox:  render_to_string(partial: "/trip_experiences/infowindow.html.erb", locals: {
              experience: experience,
              trip: trip,
              trip_experience: false,
              guest_user: false
            }),
            experience_id: experience.id,
          })
        end
      end
    end
  end
end
