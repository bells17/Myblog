require 'log4r'
require 'log4r/yamlconfigurator'
include Log4r

class PostsController < ApplicationController

	# NONE / or /posts
	# 記事の一覧を表示します。
	def index
		# アクション内のインスタンス変数はviewから呼び出せる
		@posts = Post.all(:order => "created_at DESC")

		# loger testing
		log4r_config = YAML.load_file(File.join(File.dirname(__FILE__) + '/../../config/',"log4r.yml"))
	    YamlConfigurator.decode_yaml( log4r_config['log4r_config'] )
    	logger = Log4r::Logger['publicweb']
    	logger.info("info2")
	end

	# NONE /new
	# 新規投稿ページを表示します。
	def new
		@post = Post.new
	end

	# POST /create
	# 新規投稿の登録処理を行います。
	def create
		@post = Post.new(params[:post])

		if @post.save
			redirect_to posts_path, :notice => 'create new Post!'
		else
			render :action => 'new'
		end
	end

	# NONE /posts/:id
	# ブログの詳細を表示します。
	def show
		@post = Post.find(params[:id])
		@comment = Post.find(params[:id]).comments.build
	end

	# NONE /edit/:id
	# 投稿記事の編集ページを表示します。
	def edit
		@post = Post.find(params[:id])

	end

	# POST /update/:id
	# 投稿記事の編集処理を行います。
	def update
		@post = Post.find(params[:id])

		if @post.update_attributes(params[:post])
			redirect_to posts_path, :notice => "post id #{params[:id]} update done!"
		else
			render :action => 'edit'
		end

	end

	# DELETE /posts/:id
	# 投稿記事の(物理)削除を行います。
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		render :json => { :post => @post}
	end

end
