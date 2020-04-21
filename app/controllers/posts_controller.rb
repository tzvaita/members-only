class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all.order("created_at DESC")
    @post = Post.new
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "You've posted successfully!"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:post, :user_id)
  end
end
