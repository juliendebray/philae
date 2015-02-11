class AddFromGuestCommentToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :from_guest_comment, :boolean
  end
end
