class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    authorize! :read, @post
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.destroy
    @user.posts_counter -= 1
    @user.save
    redirect_to user_posts_path(@user)
  end

  def like
    @post = Post.find(params[:id])
    @post.likes.create(author: current_user)
    redirect_to user_post_path(@post.author, @post)
  end

  def create_like
    @user = current_user
    @post = Post.find(params[:id])

    begin
      @user.likes.find_or_create_by(post: @post)
      flash[:notice] = 'Post liked successfully.'
    rescue PG::UniqueViolation
      flash[:alert] = 'You have already liked this post.'
    end

    redirect_to user_post_path(@user, @post)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
