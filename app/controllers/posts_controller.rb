class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    Post.create(post_params)
    redirect_to '/'
  end

  def post_params
    params.require(:post).permit(:caption)
  end
end
