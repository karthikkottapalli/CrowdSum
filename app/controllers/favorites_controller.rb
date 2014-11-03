class FavoritesController < ApplicationController
  def destroy
   @post = Post.find(params[:post_id])
   @favorite = current_user.favorites.find_by_post_id(@post.id)
   authorize @favorite 
   if @favorite.destroy
      flash[:notice] = "Post was unfavorited."
      redirect_to [@post.topic,@post]
   else
      flash[:error] = "There was an error unfavoriting this post."
      render :show
   end
 end
 def create
   @post = Post.find(params[:post_id])
   @favorite = current_user.favorites.build(post: @post)
   authorize @favorite 
   if @favorite.save   
      redirect_to [@post.topic,@post], notice: "Favorite was saved successfully!"
   else
      flash[:error] = "There was an error saving the favorite. Please try again."
      render :new
   end
 end
end
