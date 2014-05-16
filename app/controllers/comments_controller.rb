class CommentsController < ApplicationController

	def new
		@post = Post.find(params[:id])
		@comment = Comment.new(post_id: params[:id])
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
  			redirect_to post_path(:id => @comment[:post_id])
  			flash[:notice] = "Comment Added"
  		else
  			@id = @comment[:post_id]
  			@post = Post.find(@id)
  			render "new", post_id: @id
  		end
	end

	private 

  	def comment_params
  		params.require(:comment).permit(:content, :post_id)
  	end


end
