class AddCategoryTabToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :category_tab, :string
  end
end
