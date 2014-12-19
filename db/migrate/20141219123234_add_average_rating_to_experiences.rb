class AddAverageRatingToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :average_rating, :float
  end
end
