class RelationshipsController < ApplicationController
  def create
    if friend = User.find_by(email: params[:email])
      current_user.relationships.create(
        friend_id: friend.id,
        sender_id: current_user.id,
        )
      friend.relationships.create(
        friend_id: current_user.id,
        sender_id: current_user.id,
        )
      redirect_to user_path(current_user)
    else
      flash[:notice] = 'No such email found in our database'
      redirect_to user_path(current_user)
    end
  end

  private

  def relationship_params
  end

end
