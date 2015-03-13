class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated."
      redirect_to edit_user_registration_path
    else
      flash[:notice] = "Invalid user information."
      redirect_to edit_user_registration_path
    end
  end

  def show
    @user = User.find(params[:id])
    @correspondences = @user.all_correspondences
    # Scope candidate?
    @favorite_correspondences = @user.favorites.map { |favorite| favorite.correspondence }
    @followings = @user.followings.all
  end


  private

  def user_params
    params.require(:user).permit(:name)
  end

end
