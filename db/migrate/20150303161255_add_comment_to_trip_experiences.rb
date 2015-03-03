class AddCommentToTripExperiences < ActiveRecord::Migration
  def change
    add_column :trip_experiences, :comment, :text
  end
end
