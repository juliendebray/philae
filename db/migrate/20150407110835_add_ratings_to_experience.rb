class AddRatingsToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :ta_rating, :float
    add_column :experiences, :ta_votes, :integer
    add_column :experiences, :gg_rating, :float
    add_column :experiences, :gg_votes, :integer
    add_column :experiences, :fsq_rating, :float
    add_column :experiences, :fsq_votes, :integer
  end
end
