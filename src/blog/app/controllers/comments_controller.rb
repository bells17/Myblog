class CommentsController < ApplicationController

	#
	# コメントの登録を行います。
	def create
		@post = Post.find(params[:post_id])
		@comment = Post.find(params[:post_id]).comments.create(params[:comment])

		if @comment.save
			redirect_to post_path(@post)
		else
			render :template => 'posts/show'
		end
	end

	#
	# コメントの削除を行います。
	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		render :json => { :comment => @comment}
	end

end
