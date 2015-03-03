class CommentsController < ApplicationController

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comments = @discussion.comments
    @comment = current_user.comments.build(comment_params)
    @comment.discussion = @discussion
    @new_comment = Comment.new

    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to @discussion
    else
      flash[:error] = "Error saving comment. Please try again."
      redirect_to @discussion
    end

  end

  def destroy
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment removed."
      redirect_to @discussion
    else
      flash[:notice] = "Comment deleted."
      redirect_to @discussion
    end

  end



  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
