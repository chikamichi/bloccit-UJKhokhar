class PostPolicy < ApplicationPolicy
  def new
    @post = Post.new
     authorize @post
  end
end