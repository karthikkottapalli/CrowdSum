class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(user: @user, post: @post, body: params[:comment].require(:body))
    @comment.save!
    redirect_to :back
  end   
end