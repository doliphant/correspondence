class DiscussionsController < ApplicationController
  def index
    @discussions = Discussion.all
  end

  def show
    @discussion = Discussion.find(params[:id])
    @posts = @discussion.posts
    @new_post = Post.new
  end

  def new
    @discussion = Discussion.new
  end

  def create

    @discussion = Discussion.new(discussion_params)
    @discussion.creator = current_user
    @discussion.participant = User.find_by(email: params[:email])

    # build in check for participant user existing
    # if user exists
    #   perform the save
    # else
    #   flash error message
    # end

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

    if @discussion.update_attributes(discussion_params)
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

  def discussion_params
    params.require(:discussion).permit(:title, :description, :public)
  end

end
