class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
  
    if favorite.save
      flash[:notice] = "Post was favorited."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Favoriting failed. Please try again."
      redirect_to [@post.topic, @post]
    end

  end

end
