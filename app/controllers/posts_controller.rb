class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @discussion = Discussion.find(params[:discussion_id])
  end

  def new
    @discussion = Discussion.find(params[:discussion_id])
    @post = Post.new
  end

  def edit
    @discussion = Discussion.find(params[:discussion_id])
    @post = Post.find(params[:id])
  end

  def update
    @discussion = Discussion.find(params[:discussion_id])
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      flash[:notice] = "Contribution has been updated."
      redirect_to [@discussion]
    else
      flash[:error] = "There was an error updating your contribution. Please try again."
      render :edit
    end
  end

  def create
    @discussion = Discussion.find(params[:discussion_id])
    # @post = current_user.posts.build(post_params)
    @post = Post.new(post_params)
    @post.discussion = @discussion
    @post.user = current_user

    if @post.save
      flash[:notice] = "Your contribution has been saved."
      redirect_to [@discussion]
    else
      flash[:error] = "There was an error saving your contribution. Please try again."
      render :new
    end

  end

  def destroy
    @discussion = Discussion.find(params[:discussion_id])
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "Post has been deleted."
      redirect_to @discussion
    else
      flash[:error] = "Error deleting the post."
      redirect_to @discussion
    end

  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
