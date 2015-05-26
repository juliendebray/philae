class AddCountryCodeToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :country_code, :string
  end
end
