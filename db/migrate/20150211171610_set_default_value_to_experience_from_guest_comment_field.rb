class SetDefaultValueToExperienceFromGuestCommentField < ActiveRecord::Migration
  def change
    change_column_default(:experiences, :from_guest_comment, false)
  end
end
