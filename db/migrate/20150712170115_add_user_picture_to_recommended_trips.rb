class AddUserPictureToRecommendedTrips < ActiveRecord::Migration
  def change
    add_column :recommended_trips, :suggested_by_picture, :text
  end
end
