# coding: utf-8
# コメントコントローラー
# コメント処理を行います。

class CommentsController < ApplicationController

  #
  # コメントの登録を行います。
  def create
    @@_logger.debug(Common.function_name+" called")
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
    @@_logger.debug(Common.function_name+" called")
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :json => { :comment => @comment}
  end

end
