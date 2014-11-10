class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(user: @user, post: @post, body: params[:comment].require(:body))
    @comment.save!
    redirect_to :back
  end   

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
 
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@post.topic, @post]
    end
  end
end