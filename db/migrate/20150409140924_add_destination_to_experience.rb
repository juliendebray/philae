class AddDestinationToExperience < ActiveRecord::Migration
  def change
    add_reference :experiences, :destination, index: true
  end
end
