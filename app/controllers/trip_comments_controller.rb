class TripCommentsController < ApplicationController
  before_action :set_trip, only: [:create, :comments_markers]
  respond_to :js, only: [:comments_markers]

  def create
    @trip_comment = @trip.trip_comments.create(trip_comments_params)
  end

  def destroy
    @trip_comment = TripComment.find(params[:id])
    @trip = @trip_comment.trip
    @trip_comment.destroy
  end

  def comments_markers
    @markers = build_markers_comments(@trip.trip_comments, false)
    render json: @markers
  end

  private
  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def trip_comments_params
    params.require(:trip_comment).permit(:name, :address, :description, :latitude, :longitude)
  end

  def build_markers_comments(trip_comments, guest_user)
    Gmaps4rails.build_markers(trip_comments) do |trip_comment, marker|
      marker.lat trip_comment.latitude
      marker.lng trip_comment.longitude
      marker.json({
        infobox:  render_to_string(partial: "/trip_comments/infowindow.html.erb", locals: {
          trip_comment: trip_comment,
          guest_user: guest_user
        })
      })
      marker.title trip_comment.name
    end
  end
end
