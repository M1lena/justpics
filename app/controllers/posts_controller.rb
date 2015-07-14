class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to '/'
  end

  def new
    @post = Post.new
  end

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
