class AddOrderToTripExperiences < ActiveRecord::Migration
  def change
    add_column :trip_experiences, :order, :integer
  end
end
