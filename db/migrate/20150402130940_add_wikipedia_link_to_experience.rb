class AddWikipediaLinkToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :wikipedia_link, :string
  end
end
