class AddGlobalcontentToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :sentence4, :text
    add_column :destinations, :sentence5, :text
    add_column :destinations, :enter_title, :text
    add_column :destinations, :enter_line1, :text
    add_column :destinations, :enter_line2, :text
    add_column :destinations, :enter_line3, :text
    add_column :destinations, :visit_time_title, :text
    add_column :destinations, :visit_line1, :text
    add_column :destinations, :visit_line2, :text
    add_column :destinations, :visit_line3, :text
    add_column :destinations, :security_title, :text
    add_column :destinations, :security_line1, :text
    add_column :destinations, :security_line2, :text
    add_column :destinations, :transport_title, :text
    add_column :destinations, :transport_line1, :text
    add_column :destinations, :transport_line2, :text
    add_column :destinations, :transport_line3, :text
    add_column :destinations, :transport_line4, :text
    add_column :destinations, :transport_line5, :text
    add_column :destinations, :toknow_title, :text
    add_column :destinations, :toknow_line1, :text
    add_column :destinations, :toknow_line2, :text
    add_column :destinations, :toknow_line3, :text
    add_column :destinations, :toknow_line4, :text
    add_column :destinations, :toknow_line5, :text
  end
end
