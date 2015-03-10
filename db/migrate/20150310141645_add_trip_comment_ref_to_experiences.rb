class AddTripCommentRefToExperiences < ActiveRecord::Migration
  def change
    add_reference :experiences, :trip_comment, index: true
  end
end
