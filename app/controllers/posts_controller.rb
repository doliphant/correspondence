class PostsController < ApplicationController
  def show
  end

  def new
  end

  def edit
  end

  def destroy
    @discussion = Discussion.find(params[:topic_id])
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "Post has been deleted."
      redirect_to @discussion
    else
      flash[:error] = "Error deleting the post."
      redirect_to @discussion
    end

  end

end
