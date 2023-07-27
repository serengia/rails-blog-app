class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    # Eager loading comments and likes for the user's posts
    @posts = @user.posts.includes(:comments, :likes)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.five_most_recent_comments
  end

  def new
    @post = @current_user.posts.new
  end

  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(@current_user)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
