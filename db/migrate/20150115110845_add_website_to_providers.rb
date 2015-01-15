class AddWebsiteToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :website, :string
  end
end
