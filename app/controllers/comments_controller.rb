class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = @current_user.comments.new(comment_params)
    @comment[:post_id] = params[:post_id]

    user_id = @comment.author_id
    post_id = @comment.post_id

    # Find the corresponding User and Post records using their IDs
    @user = User.find(user_id)
    @post = Post.find(post_id)

    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
