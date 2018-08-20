class CommentController < ApplicationController
	before_action :authenticate_user!
	
	def create
		c = Comment.new
		c.content = params[:comment][:content]
		c.dbpost_id = params[:comment][:post_id]
		c.user_id = current_user.id
		c.save
		redirect_to "/post/show?p_id=#{c.dbpost.id}"
	end



	def destroy
		comment = Comment.find params[:id]
		temp = comment.dbpost.id
		comment.destroy
		redirect_to "/post/show?p_id=#{temp}"
	end
end
