require "html_truncator"

class PostsController < ApplicationController

  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
  	@posts = Post.all 
    @posts.reverse!
  end

  def show
  	@post = Post.find(params[:id])
    @id = params[:id]
  end

  def new
  	@post = Post.new

  end

  def create
  	@post = Post.new(post_params)

  	if @post.save
  		redirect_to posts_path
  		flash[:notice] = "Post Created"
  	else
  		render "new"
  	end
  end

  def edit
    find_post

  end

  def update
    find_post
    if @post.update(post_params)
      redirect_to posts_path(params[:post_id])
      flash[:notice] = "Your post was updated."
    else
      render "edit"
    end
  end

  def destroy
    find_post
    @post.delete
    redirect_to posts_path
    flash[:notice] = "Your post was deleted."
  end

  def front
    @post = Post.last
    @safe_content = HTML_Truncator.truncate(@post.content, 130)
  end




  private 

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :content)
  end

  def check_admin

    @current_user = User.find(session[:user_id]) if session[:user_id]

    if @current_user
      if @current_user.admin
        true
      else
        redirect_to posts_path
        flash[:notice] = "You do not have permission to do that"
      end
    else
      redirect_to login_path
    end
  end
end

