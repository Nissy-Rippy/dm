class RelationshipsController < ApplicationController

  def create
      current_user.follow(params[:user_id])
      redirect_to request.referer
  end

  def destroy
      current_user.unfollow(params[:user_id])
      redirect_to request.referer
  end

  def followers
      @user = User.find_by(params[:id])
      @users = @user.followers
  end

  def followings
      @user = User.find_by(params[:id])
      @users = @user.followings
  end



end
