class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to :back
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = @post.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was deleted successfully."
    else
      flash[:error] = "There was an error deleting the comment. Please try again."
    end
  end

  respond_to do |format|
    format.html
    format.js
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
