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

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
  		redirect_to post_path(:id => @comment[:post_id])
  		flash[:notice] = "Comment Deleted"
  	end

  	def edit
  		@comment = Comment.find(params[:id])
  		@post = Post.find(@comment[:post_id])
  	end


  	def update
  		@comment = Comment.find(params[:id])
        if @comment.update( comment_params )
        	redirect_to post_path(:id => @comment[:post_id]) 
        	flash[:notice] = 'Your comment was updated.'
        else
        	render action: 'edit', post_id: @id
        end
    end



	private 

  	def comment_params
  		params.require(:comment).permit(:content, :post_id)
  	end


end
