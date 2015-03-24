class CreateRecommendedTripExperiences < ActiveRecord::Migration
  def change
    create_table :recommended_trip_experiences do |t|
      t.references :recommended_trip, index: true
      t.references :experience, index: true
      t.integer :order

      t.timestamps
    end
  end
end
