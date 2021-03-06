class TripExperiencesController < ApplicationController
  before_action :set_trip, only: [:markers, :markers_popularity, :trip_markers, :create, :create_with_new_experience, :must_see, :recommended_trip]
  before_action :authenticate_user!, only: [:update, :must_see, :recommended_trip]
  respond_to :js, only: [:create, :trip_markers, :destroy, :create_with_new_experience, :create_with_comment]


  def markers
    markers_number = 70
    experiences_within_bounds = Experience.where(published: true, country_code: @trip.country_code).within_bounding_box([params[:SWLA].to_f, params[:SWLO].to_f, params[:NELA].to_f, params[:NELO]])
    @experiences = select_experiences_to_show(experiences_within_bounds)
    @markers = build_markers(@experiences[0..markers_number - 1], @trip, true)
    render json: @markers
  end

  def markers_popularity
    markers_number = 20
    experiences_within_bounds = Experience.where(published: true).within_bounding_box([params[:SWLA].to_f, params[:SWLO].to_f, params[:NELA].to_f, params[:NELO]])
    @experiences = select_experiences_to_show_by_popularity(experiences_within_bounds)
    @markers = build_markers(@experiences[0..markers_number - 1], @trip, true)
    render json: @markers
  end

  def trip_markers
    @experiences = []
    if @trip.user.nil? || @trip.user == current_user
      @markers = build_markers_with_trip_experiences(@trip.trip_experiences.sort_by { |te| te.order }, @trip, false)
    else
      trip_experiences = []
      @trip.trip_experiences.each do |trip_exp|
        trip_experiences << trip_exp unless trip_exp.experience.from_guest_comment
      end
      @markers = build_markers_with_trip_experiences(trip_experiences.sort_by { |te| te.order }, @trip, true)
    end
    render json: @markers
  end

  def create
    @trip_experience = @trip.trip_experiences.create(trip_experience_params)
  end

  def destroy
    @trip_experience = TripExperience.find(params[:id])
    @trip = @trip_experience.trip
    if @trip_experience.experience && @trip_experience.experience.trip_comment
      @trip_experience.experience.trip_comment.update(add_to_trip: false, experience_id: nil)
    end
    @trip_experience.destroy
  end

  def update
    @trip_experience = TripExperience.find(params[:id])
    @trip_experience.update(comment: params[:trip_experience][:comment])
  end

  def create_with_new_experience
    if current_user
      @experience = current_user.experiences.create(experience_params)
    else
      @experience = Experience.create(experience_params)
    end
    @trip_experience = @trip.trip_experiences.create(experience_id: @experience.id)
  end

  def create_with_comment
    @trip_comment = TripComment.find(params[:trip_comment_id])
    @trip = @trip_comment.trip
    if current_user
      @experience = current_user.experiences.create(
        name: "Tips: #{@trip_comment.name}",
        address: @trip_comment.address,
        latitude: @trip_comment.latitude,
        longitude: @trip_comment.longitude,
        description: @trip_comment.description,
        from_guest_comment: true,
        trip_comment_id: @trip_comment.id
      )
    else
      @experience = Experience.create(
        name: "Tips: #{@trip_comment.name}",
        address: @trip_comment.address,
        latitude: @trip_comment.latitude,
        longitude: @trip_comment.longitude,
        description: @trip_comment.description,
        from_guest_comment: true,
        trip_comment_id: @trip_comment.id
      )
    end
      @trip_comment.update(add_to_trip: true, experience_id: @experience.id)
      @trip_experience = @trip.trip_experiences.create(experience_id: @experience.id)

  end

  def must_see
    # TODO: Link Experience to destination
    @destination = Destination.first
    # @markers = build_markers(Experience.within_bounding_box([@destination.sw_lat, @destination.sw_lng, @destination.ne_lat, @destination.ne_lng]).to_a, @trip, false)
    @markers = build_markers(Experience.where(must_see: true).to_a, @trip, false)
    render json: @markers
  end

  def recommended_trip
    recommended_trip = RecommendedTrip.find(params[:rti])
    experiences_ordered = []
    recommended_trip.recommended_trip_experiences.sort_by {|reco_trip_exp| reco_trip_exp.order }.each do |reco_trip_exp|
      experiences_ordered << reco_trip_exp.experience
    end
    @markers = build_markers(experiences_ordered, @trip, false)
    render json: @markers
  end

 private
 def trip_experience_params
    params.require(:trip_experience).permit(:experience_id)
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
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
      elsif experience.landing_point
        picture_url = "https://philae-floju.s3.amazonaws.com/markers/airport_logo.png"
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

  def experience_params
    params.require(:experience).permit(:name, :address, :latitude, :longitude, :description, :category_id, experience_pictures_attributes: [:picture])
  end

  def select_experiences_to_show(experiences)
    experiences_with_rating = []
    experiences_to_show = []
    experiences.each do |exp|
      experiences_with_rating << exp if exp.average_rating
    end
    experiences_to_show = experiences_with_rating.sort_by { |e| e.average_rating }
    experiences_to_show = experiences_to_show.reverse
    experiences.each do |exp|
      experiences_to_show << exp unless exp.average_rating
    end
    experiences_to_show
  end

  # TODO: Rethink the logic, smg better should exist and factorize
  def select_experiences_to_show_by_popularity(experiences)
    experiences_with_votes = []
    experiences_to_show = []
    experiences.each do |exp|
      experiences_with_votes << exp if exp.nb_votes
    end
    experiences_to_show = experiences_with_votes.sort_by { |e| e.nb_votes }
    experiences_to_show = experiences_to_show.reverse
    experiences.each do |exp|
      experiences_to_show << exp unless exp.nb_votes
    end
    experiences_to_show
  end

  def build_markers_with_trip_experiences(trip_experiences, trip, guest_user)
    Gmaps4rails.build_markers(trip_experiences) do |trip_experience, marker|
      marker.lat trip_experience.experience.latitude
      marker.lng trip_experience.experience.longitude
      # trip_experience.experience.must_see ? picture_url = "https://philae-floju.s3.amazonaws.com/markers/selection_must_see.png" : picture_url = "https://philae-floju.s3.amazonaws.com/markers/selection.png"
      marker.picture({
        url: "https://philae-floju.s3.amazonaws.com/markers/selection.png",
        width:  25,
        height: 39
      })
      marker.json({
        infobox:  render_to_string(partial: "/trip_experiences/infowindow.html.erb", locals: {
          experience: trip_experience.experience,
          trip: trip,
          trip_experience: trip_experience,
          guest_user: guest_user
        }),
        experience_id: trip_experience.experience.id,
        experience_block: render_to_string(partial: "/trip_experiences/experience_block.html.erb", locals: {
          trip_exp: trip_experience,
          guest_user: guest_user,
          experience: guest_user,
          trip: trip
        })
      })
      marker.title trip_experience.experience.name
    end
  end
end
