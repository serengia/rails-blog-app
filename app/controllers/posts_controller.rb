class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :set_user, only: %i[index show new]

  def index
    @posts = Post.all
  end

  def new
  end

  def show
    @comments = @post.five_most_recent_comments
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(@current_user)
    else
      render :new
    end
  end


  def post_params
    params.require(:post).permit(:title, :text)
  end
end
