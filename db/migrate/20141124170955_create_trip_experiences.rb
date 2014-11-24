class CreateTripExperiences < ActiveRecord::Migration
  def change
    create_table :trip_experiences do |t|
      t.references :trip, index: true
      t.references :experience, index: true

      t.timestamps
    end
  end
end
