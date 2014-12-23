class TripExperiencesController < ApplicationController
  before_action :set_trip, only: [:markers, :trip_markers, :create, :create_with_new_experience]
  respond_to :js, only: [:create, :trip_markers, :destroy, :create_with_new_experience]

  def markers
    markers_number = 10
    experiences_within_bounds = Experience.where(published: true).within_bounding_box([params[:SWLA].to_f, params[:SWLO].to_f, params[:NELA].to_f, params[:NELO]])
    @experiences = select_experiences_to_show(experiences_within_bounds)
    @markers = build_markers(@experiences[0..markers_number - 1], @trip)
    render json: @markers
  end

  def trip_markers
    @experiences = []
    @trip.trip_experiences.each do |trip_exp|
      @experiences << trip_exp.experience
    end
    @markers = build_markers(@experiences, @trip)
    render json: @markers
  end

  def create
    @trip_experience = @trip.trip_experiences.create(trip_experience_params)
  end

  def destroy
    @trip_experience = TripExperience.find(params[:id])
    @trip_experience.destroy
  end

  def create_with_new_experience
    @experience = Experience.create(experience_params)
    @trip_experience = @trip.trip_experiences.create(experience_id: @experience.id)
  end

 private
 def trip_experience_params
    params.require(:trip_experience).permit(:experience_id)
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def build_markers(experiences, trip)
    Gmaps4rails.build_markers(experiences) do |experience, marker|
      marker.lat experience.latitude
      marker.lng experience.longitude
      marker.json({
        infobox:  render_to_string(partial: "/trip_experiences/infowindow.html.erb", locals: {
        experience: experience,
        trip: trip
        })
      })
      marker.title experience.name
    end
  end

  def experience_params
    params.require(:experience).permit(:name, :address, :description, :category_id, experience_pictures_attributes: [:picture])
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

end
