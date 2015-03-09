class CommentsController < ApplicationController

  def create
    @correspondence = Correspondence.find(params[:correspondence_id])
    @comments = @correspondence.comments
    @comment = current_user.comments.build(comment_params)
    @comment.correspondence = @correspondence
    @new_comment = Comment.new
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to @correspondence
    else
      flash[:error] = "Error saving comment. Please try again."
      redirect_to @correspondence
    end

  end

  def destroy
    @correspondence = Correspondence.find(params[:correspondence_id])
    @comment = Comment.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment removed."
      redirect_to @correspondence
    else
      flash[:notice] = "Comment deleted."
      redirect_to @correspondence
    end

  end



  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
