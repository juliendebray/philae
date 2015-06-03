class AddCountryCodeToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :country_code, :string
  end
end
