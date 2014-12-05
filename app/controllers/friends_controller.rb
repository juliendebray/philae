class FriendsController < ApplicationController

  def index
    @friend = Friend.all
      respond_to do |format|
    format.html
    format.json { render json: @friend }
    end
  end

  def fb_friends
    @user_fb_token = current_user.token

    unless @user_fb_token.blank?
      @fb_friends = FbGraph::User.me(@user_fb_token.access_token).friends
      @fb_friends = @fb_friends.sort_by { |fb_frnd| fb_frnd.raw_attributes['name']}
    end

  end

end
