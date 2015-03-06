class DiscussionsController < ApplicationController
  def index
    @discussions = Discussion.all
    authorize @discussions
  end

  def show
    @discussion = Discussion.find(params[:id])
    @posts = @discussion.posts
    @new_post = Post.new
    @comments = @discussion.comments
    @new_comment = Comment.new
    authorize @discussion
  end

  def new
    @discussion = Discussion.new
    authorize @discussion
  end

  def create

    @discussion = Discussion.new(discussion_params)
    @discussion.creator = current_user
    @discussion.participant = User.find_by(email: params[:email])
    authorize @discussion

    if @discussion.participant.nil?
      flash[:error] = "Participant cannot be found."
      # redirect_to form but keep signed in data.
      redirect_to new_discussion_path
    else

      if @discussion.save
        flash[:notice] = "Correspondence has been created."
        redirect_to @discussion
      else
        flash[:error] = "Sorry about that, we had an error. Please try again."
        render new_discussion_path
      end

    end
  end

  def edit
    @discussion = Discussion.find(params[:id])
    authorize @discussion
  end

  def update
    @discussion = Discussion.find(params[:id])
    authorize @discussion

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
