class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:text))
    @comment.author = current_user
    @comment.postId = @post.id

    if @comment.save
      flash[:success] = 'Comment was successfully created.'
      redirect_to post_url(@user.id, @post.id)
    else
      flash.now[:error] = 'Please fill all fields'
      render :new, status: 422
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to post_path(params[:id], params[:post_id])
  end

  def strong_params
    params.require(:comment).permit(:post, :text)
  end
end
