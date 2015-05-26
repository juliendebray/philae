class AddContentToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :intro_title, :text
    add_column :destinations, :sentence1, :text
    add_column :destinations, :sentence2, :text
    add_column :destinations, :sentence3, :text
  end
end
