class CreateRecommendedTrips < ActiveRecord::Migration
  def change
    create_table :recommended_trips do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
