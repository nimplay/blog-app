class UsersController < ApplicationController
  def index
    @users = User.all
    @current = current_user
  end

  def show
    @user = current_user
    # @user = User.find(params[:id])
    @post = Post.where(authorId: @user.id)
  end
end
