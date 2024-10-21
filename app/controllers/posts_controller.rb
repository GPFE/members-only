class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(get_params) # to-do add user_id
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def get_params
    params.require(:post).permit(:title, :content)
  end
end
