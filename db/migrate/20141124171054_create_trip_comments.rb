class CreateTripComments < ActiveRecord::Migration
  def change
    create_table :trip_comments do |t|
      t.references :user, index: true
      t.string :name
      t.string :address
      t.string :description
      t.references :trip, index: true

      t.timestamps
    end
  end
end
