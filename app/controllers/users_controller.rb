class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def user_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          # flash now makes it so that the messages goes away on the next valid search
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a friend name or email to search'
        format.js { render partial: 'users/friend_result' }
      end
    end
  end
end
