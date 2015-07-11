class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def new
  end

  def create
    Post.create(post_params)
    redirect_to '/'
  end

  def post_params
    params.require(:post).permit(:caption)
  end
end
