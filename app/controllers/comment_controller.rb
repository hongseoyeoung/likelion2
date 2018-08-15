class CommentController < ApplicationController
	def create
		comment = Comment.new
		comment.content = params[:comment_content]
		comment.post_id = params[:post_id]
		comment.save
		redirect_to "/post/#{comment.post.id}"
		
	end

	def destroy
		comment = Comment.find params[:id]
		comment.destroy
		redirect_to '/post/#{comment.post.id}'
	end
end
