class LikesController < ApplicationController
  def new; end

  def create
    @post = Post.find(params[:post_id])
    @like = @current_user.likes.new(post_id: @post.id)
    @like.author = @current_user
    if @like.save
      redirect_to user_post_path(@current_user, @post)
    else
      render :new
    end
  end
end
