class FavoritesController < ApplicationController

  def create
    @correspondence = Correspondence.find(params[:correspondence_id])
    @favorite = current_user.favorites.build(correspondence: @correspondence)

    if @favorite.save
      flash[:notice] = "Correspondence is now a favorite!"
      redirect_to @correspondence
    else
      flash[:error] = "Post could not be made favorite."
      redirect_to @correspondence
    end
  end

  def destroy
    @correspondence = Correspondence.find(params[:correspondence_id])
    @favorite = current_user.favorited(@correspondence)

    if @favorite.destroy
      flash[:notice] = "Correspondence has been Unfavorited."
      redirect_to @correspondence
    else
      flash[:error] = "Post could not be Unfavorited."
      redirect_to @correspondence
    end
  end

end
