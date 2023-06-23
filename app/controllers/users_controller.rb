class UsersController < ApplicationController
  def index
    render plain: "Here is a list of users"
  end

  def show
    render plain: "Here is the profile for user ##{params[:id]}"
  end
end
