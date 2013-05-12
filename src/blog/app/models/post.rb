# 記事モデル
# 投稿記事モデルです。

class Post < ActiveRecord::Base
	attr_accessible :content, :title
	has_many :comments

	# validation setting
	validates :title, 	:presence 	=> true
	validates :content,	:presence 	=> true,
						:length 	=> { :minimum => 5 }
end
