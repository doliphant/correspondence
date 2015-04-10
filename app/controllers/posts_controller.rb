class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @correspondence = Correspondence.find(params[:correspondence_id])
    authorize @post
  end

  def new
    @correspondence = Correspondence.find(params[:correspondence_id])
    @post = Post.new
  end

  def edit
    @correspondence = Correspondence.find(params[:correspondence_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @correspondence = Correspondence.find(params[:correspondence_id])
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      flash[:notice] = "Contribution has been updated."
      redirect_to [@correspondence]
    else
      flash[:error] = "There was an error updating your contribution. Please try again."
      render :edit
    end
  end

  def create
    @correspondence = Correspondence.find(params[:correspondence_id])
    @post = Post.new(post_params)
    @post.correspondence = @correspondence
    @post.user = current_user

    if @post.save
      flash[:notice] = "Your contribution has been saved."
      redirect_to [@correspondence]
    else
      flash[:error] = "There was an error saving your contribution. Please try again."
      render :new
    end

  end

  def destroy
    @correspondence = Correspondence.find(params[:correspondence_id])
    @post = Post.find(params[:id])
    #post destroy action deliberately restricted to destruction of the correspondence
    authorize @correspondence

    if @post.destroy
      flash[:notice] = "Post has been deleted."
      redirect_to @correspondence
    else
      flash[:error] = "Error deleting the post."
      redirect_to @correspondence
    end

  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
