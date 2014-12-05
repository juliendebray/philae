class RelationshipsController < ApplicationController
before_action :set_relationship, only: [:update, :destroy]

  def create
    if friend = User.find_by(email: params[:email])
      if current_user.relationships.where(friend_id: friend.id, status: 'accepted').size > 0
        flash[:notice] = 'Your are already friends'
      else friend = User.find_by(email: params[:email])
        current_user.relationships.create(
          friend_id: friend.id,
          sender_id: current_user.id,
          )
        friend.relationships.create(
          friend_id: current_user.id,
          sender_id: current_user.id,
          )
        flash[:notice] = 'Your request has been send'
      end
    else
      flash[:notice] = 'No such email found in our database'
    end
    redirect_to user_path(current_user)
  end

  def update
    @relationship.update(status: 'accepted')
    Relationship.where(
      sender_id: @relationship.sender_id,
      user_id: @relationship.sender_id,
      friend_id: current_user.id
    ).first.update(status: 'accepted')
    flash[:notice] = 'You have a new friend'
    redirect_to user_path(current_user)
  end

  def destroy
    @relationship.destroy
    Relationship.where(
      sender_id: @relationship.sender_id,
      user_id: @relationship.sender_id,
      friend_id: current_user.id
    ).first.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_relationship
    @relationship = Relationship.find(params[:id])
  end

end
