# coding: utf-8
# 記事コントローラー
# 投稿記事に関する処理を行います。

class PostsController < ApplicationController
 
  # NONE / or /posts
  # 記事の一覧を表示します。
  def index
    @@_logger.debug("#{Common.function_name} called")
    @posts = Post.all(:order => "created_at DESC")
    @@_logger.debug("RETURN: #{@posts.to_yaml}")
  end

  # NONE /new
  # 新規投稿ページを表示します。
  def new
    @@_logger.debug("#{Common.function_name} called")
    @post = Post.new
    @@_logger.debug("model: #{@post.to_yaml}")
  end

  # POST /create
  # 新規投稿の登録処理を行います。
  def create
    @@_logger.debug("#{Common.function_name} called.　" +
                    "params\n#{Common.getparams(params).to_yaml}")
    @post = Post.new(params[:post])
    @@_logger.debug("model: #{@post.to_yaml}")

    if @post.save
      redirect_to posts_path, :notice => 'create new Post!'
    else
      render :action => 'new'
    end
  end

  # NONE /posts/:id
  # ブログの詳細を表示します。
  def show
    @@_logger.debug("#{Common.function_name} called.　" +
                    "params\n#{Common.getparams(params).to_yaml}")
    @post     = Post.find(params[:id])
    @comment  = Post.find(params[:id]).comments.build
    @@_logger.debug("RETURN:\npost => #{@post.to_yaml}" +
            "comment => #{@comment.to_yaml}")
  end

  # NONE /edit/:id
  # 投稿記事の編集ページを表示します。
  def edit
    @@_logger.debug("#{Common.function_name} called.　" +
                    "params\n#{Common.getparams(params).to_yaml}")
    @post = Post.find(params[:id])
    @@_logger.debug("RETURN: #{@post.to_yaml}")
  end

  # POST /update/:id
  # 投稿記事の編集処理を行います。
  def update
    @@_logger.debug("#{Common.function_name} called.　" +
                    "params\n#{Common.getparams(params).to_yaml}")
    @post = Post.find(params[:id])
    @@_logger.debug("model: #{@post.to_yaml}")

    if @post.update_attributes(params[:post])
      redirect_to posts_path, :notice => "post id #{params[:id]} update done!"
    else
      render :action => 'edit'
    end

  end

  # DELETE /posts/:id
  # 投稿記事の(物理)削除を行います。
  def destroy
    @@_logger.debug("#{Common.function_name} called.　" +
                    "params\n#{Common.getparams(params).to_yaml}")
    @post = Post.find(params[:id])
    @post.destroy
    render :json => { :post => @post}
  end
 
end