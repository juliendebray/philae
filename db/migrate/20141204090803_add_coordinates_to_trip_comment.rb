class AddCoordinatesToTripComment < ActiveRecord::Migration
  def change
    add_column :trip_comments, :latitude, :float
    add_column :trip_comments, :longitude, :float
  end
end
