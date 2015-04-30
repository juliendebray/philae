class AddCategoriesTabToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :categories_tab, :string
  end
end
