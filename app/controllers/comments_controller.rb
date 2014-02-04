class CommentsController < ApplicationController
	def create

		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		
		if @comment.save
			flash[:notice] = "Your comment was added."
		else
			flash[:alert] = "Your comment was not saved."
		end
		redirect_to post_path(@post)
	end
end