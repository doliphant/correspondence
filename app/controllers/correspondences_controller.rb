class CorrespondencesController < ApplicationController

  def index
    @correspondences = policy_scope(Correspondence.paginate(page: params[:page], per_page: 15))
    authorize @correspondences
  end

  def show
    @correspondence = Correspondence.find(params[:id])
    @posts = @correspondence.posts
    @new_post = Post.new
    @comments = @correspondence.comments
    @new_comment = Comment.new
    @user = current_user

    # need a user for calls to user methods
    if @user == nil
      @user = User.new
    end

    authorize @correspondence
  end

  def new
    @correspondence = Correspondence.new
    authorize @correspondence
  end

  def create

    @correspondence = Correspondence.new(correspondence_params)
    @correspondence.creator = current_user
    @correspondence.participant = User.find_by(email: params[:email])
    authorize @correspondence

    if @correspondence.participant.nil?
      flash[:error] = "Participant cannot be found."
      render :new
    elsif @correspondence.save
      flash[:notice] = "Correspondence has been created."
      redirect_to @correspondence
    else
      flash[:error] = "Sorry about that, we had an error. Please try again."
      render :new
    end
  end

  def edit
    @correspondence = Correspondence.find(params[:id])
    authorize @correspondence
  end

  def update
    @correspondence = Correspondence.find(params[:id])
    authorize @correspondence

    if @correspondence.update_attributes(correspondence_params)
      flash[:notice] = "Correspondence has been updated."
      redirect_to @correspondence
    else
      flash[:error] = "There was an error updating the correspondence. Try again."
      render :edit
    end
  end

  def destroy
    @correspondence = Correspondence.find(params[:id])
    title = @correspondence.title

    if @correspondence.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to correspondences_path
    else
      flash[:error] = "There was an error deleting the correspondence."
      render :show
    end
  end

  def correspondence_params
    params.require(:correspondence).permit(:title, :description, :private)
  end

end
