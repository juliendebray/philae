class CreateRecommendedTripSteps < ActiveRecord::Migration
  def change
    create_table :recommended_trip_steps do |t|
      t.integer :order
      t.references :recommended_trip, index: true
      t.text :content

      t.timestamps
    end
  end
end
