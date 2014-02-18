class CommentsController < ApplicationController
	before_action :require_user, except: [:index, :show]

	def create

		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user
		
		if @comment.save
			flash[:notice] = "Your comment was added."
			redirect_to post_path(@post)
		else
			@comments = @post.comments
			render 'posts/show'
		end
	end
end