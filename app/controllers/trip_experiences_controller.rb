class TripExperiencesController < ApplicationController
  before_action :set_trip, only: [:markers, :create]
  respond_to :js, only: [:create]

  def markers

    @experiences = Experience.within_bounding_box([params[:SWLA].to_f, params[:SWLO].to_f, params[:NELA].to_f, params[:NELO]])
    @experiences.sort_by{ |e| e.experience_reviews.average(:rating) }

    @markers = Gmaps4rails.build_markers(@experiences.reverse[0..2]) do |experience, marker|
      marker.lat experience.latitude
      marker.lng experience.longitude
      marker.infowindow render_to_string(partial: "/trip_experiences/infowindow.html.erb", locals: {
        experience: experience,
        trip: @trip
      })
      marker.title experience.name
    end
    render json: @markers
  end

  def create
    @trip_experience = @trip.trip_experiences.new(trip_experience_params)
    @trip_experience.save
  end

  def destroy
  end

   private
   def trip_experience_params
      params.require(:trip_experience).permit(:experience_id)
    end

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end
end
