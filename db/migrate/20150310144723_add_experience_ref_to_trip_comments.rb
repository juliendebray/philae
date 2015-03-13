class AddExperienceRefToTripComments < ActiveRecord::Migration
  def change
    add_reference :trip_comments, :experience, index: true
  end
end
