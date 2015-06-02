class AddSecurityLine3ToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :security_line3, :text
  end
end
