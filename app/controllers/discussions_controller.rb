class DiscussionsController < ApplicationController
  def index
    @discussions = Discussion.all
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(params.require(:discussion).permit(:title, :description, :public))

    if @discussion.save
      flash[:notice] = "Correspondence has been created."
      redirect_to @discussion
    else
      flash[:error] = "There was an error saving the discussion. Try again."
      render :new
    end
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def update
    @discussion = Discussion.find(params[:id])

    if @discussion.update_attributes(params.require(:discussion).permit(:title, :description, :public))
      flash[:notice] = "Correspondence has been updated."
      redirect_to @discussion
    else
      flash[:error] = "There was an error updating the discussion. Try again."
      render :edit
    end
  end

  def destroy
    @discussion = Discussion.find(params[:id])
    title = @discussion.title

    if @discussion.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to discussions_path
    else
      flash[:error] = "There was an error deleting the discussion."
      render :show
    end
  end


end
