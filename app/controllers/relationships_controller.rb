class RelationshipsController < ApplicationController

  def create
    @follower_id = current_user.id
    @following = User.find(params[:user_id])
    @relationship = Relationship.new(follower_id: @follower_id, following_id: @following.id)

    if @relationship.save
      flash[:notice] = "You are now following #{@following.name}."
      redirect_to @following
    else
      flash[:error] = "Could not follow #{@following.name}"
      redirect_to @following
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @user = User.find(params[:user_id])

    if @relationship.destroy
      flash[:notice] = "You are no longer following #{@user.name}."
      redirect_to @user
    else
      flash[:error] = "#{@user.name} could not be unfollowed."
      redirect_to @user
    end
  end

end
