class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(posts: %i[comments likes]).find(params[:id])
    @posts = Post.where(author_id: @user.id)
  end
end
