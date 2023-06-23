class UsersController < ApplicationController
  def index
    render plain: "Here is a list of users"
  end
end
