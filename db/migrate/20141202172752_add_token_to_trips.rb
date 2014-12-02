class AddTokenToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :token, :string
  end
end
