class AddFromCampaignToUsers < ActiveRecord::Migration
  def change
    add_column :users, :from_campaign, :string
  end
end
