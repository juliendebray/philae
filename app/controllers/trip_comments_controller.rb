class TripCommentsController < ApplicationController
  before_action :set_trip, only: [:create, :comments_markers]
  respond_to :js, only: [:comments_markers]

  def create
    # @trip = Trip.find(params[:trip_id])
    # p @trip.id
    @trip_comment = @trip.trip_comments.create(trip_comments_params)
    # puts '$$$$$$$$$$$$$$$$$$$'
    # @marker = {}
    # @marker[:lat] = @trip_comment.latitude
    # @marker[:lng] = @trip_comment.longitude
    # @marker[:infobox] = render_to_string(partial: "/trip_comments/infowindow.html.erb", locals: {
    #   trip_comment: @trip_comment,
    #   trip: @trip
    # })
    # @marker[:title] = @trip_comment.name


    # puts @marker
    # puts 'ssssssss--------- JSON ------------ ssssssss'
    # puts @marker.to_json

    # markers = build_markers_comments([@trip_comment], @trip)
    # puts '$$$$$$$$$$$$$$$$$$$'

    # @marker = markers[0].to_json

    # p @markers
    # # p session['session_id']
  end

  def destroy
    @trip_comment = TripComment.find(params[:id])
    @trip_comment.destroy
  end

  def comments_markers
    # if current_user = @trip.user
    #   @markers = build_markers_comments(@trip.trip_comments, @trip)
    # elsif condition

    # end
    @markers = build_markers_comments(@trip.trip_comments, @trip)
    render json: @markers
  end

  private
  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def trip_comments_params
    params.require(:trip_comment).permit(:name, :address, :description, :latitude, :longitude)
  end

  def build_markers_comments(trip_comments)
    Gmaps4rails.build_markers(trip_comments) do |trip_comment, marker|
      marker.lat trip_comment.latitude
      marker.lng trip_comment.longitude
      marker.json({
        infobox:  render_to_string(partial: "/trip_comments/infowindow.html.erb", locals: {
          trip_comment: trip_comment
        })
      })
      marker.title trip_comment.name
    end
  end
end
