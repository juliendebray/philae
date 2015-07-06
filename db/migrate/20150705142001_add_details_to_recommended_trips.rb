class AddDetailsToRecommendedTrips < ActiveRecord::Migration
  def change
    add_column :recommended_trips, :duration, :text
    add_column :recommended_trips, :good_points, :text
    add_column :recommended_trips, :rythm, :text
    add_column :recommended_trips, :suggested_by, :string
    add_column :recommended_trips, :suggested_by_detail, :text
  end
end
