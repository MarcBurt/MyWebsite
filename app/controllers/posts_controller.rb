class PostsController < ApplicationController
  def index
  	@posts = Post.all 
  end

  def show
  	@post = Post.find(params[:id])

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
      redirect_to posts_path
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
  end




  private 

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :content)
  end
end
