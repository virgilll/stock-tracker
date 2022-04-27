class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    # same friend key from html form
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following user"
    else
      flash[:alert] = "Error"
    end
    redirect_to user_friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Unfollowed successfully"
    redirect_to user_friends_path
  end
end
