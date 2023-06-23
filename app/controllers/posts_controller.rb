class PostsController < ApplicationController
  def index
    render plain: "Here is a list of posts for user ##{params[:user_id]}"
  end

  def show
    render plain: "Here is post ##{params[:id]} for user ##{params[:user_id]}"
  end
end
