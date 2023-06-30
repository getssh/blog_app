class UsersController < ApplicationController
  def index
    @user = User.includes(posts: [:comments, :likes]).find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
end
