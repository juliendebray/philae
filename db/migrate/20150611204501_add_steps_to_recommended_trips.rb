class AddStepsToRecommendedTrips < ActiveRecord::Migration
  def change
    add_column :recommended_trips, :step_1, :text
    add_column :recommended_trips, :step_2, :text
    add_column :recommended_trips, :step_3, :text
    add_column :recommended_trips, :step_4, :text
    add_column :recommended_trips, :step_5, :text
    add_column :recommended_trips, :step_6, :text
    add_column :recommended_trips, :step_7, :text
    add_column :recommended_trips, :step_8, :text
    add_column :recommended_trips, :step_9, :text
    add_column :recommended_trips, :step_10, :text
    add_column :recommended_trips, :step_11, :text
    add_column :recommended_trips, :step_12, :text
    add_column :recommended_trips, :step_13, :text
    add_column :recommended_trips, :step_14, :text
    add_column :recommended_trips, :step_15, :text
  end
end
