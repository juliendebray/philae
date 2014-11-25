class AddCoordinatesToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :latitude, :float
    add_column :experiences, :longitude, :float
  end
end
