class AddNbVotesToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :nb_votes, :integer
  end
end
