class AddCountryCodeToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :country_code, :string
  end
end
