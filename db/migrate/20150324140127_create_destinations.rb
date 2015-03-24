class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.float :ne_lat
      t.float :ne_lng
      t.float :sw_lat
      t.float :sw_lng
      t.string :name
      t.text :overview
      t.text :formalities
      t.text :regions
      t.text :transportation

      t.timestamps
    end
  end
end
