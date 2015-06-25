class AddPointsToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :good_points, :text
    add_column :experiences, :bad_points, :text
    add_column :experiences, :explorizers_tip, :text
    add_column :experiences, :where_to_eat, :text
  end
end
