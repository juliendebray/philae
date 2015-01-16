class AddOtherToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :other, :text
  end
end
