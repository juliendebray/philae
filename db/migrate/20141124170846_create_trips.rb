class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
