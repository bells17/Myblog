# encoding: utf-8
require 'spec_helper'

describe Post do

	# fixturesから対象のyamlを実行します。
	fixtures :posts

	# 初回時のみの初期化処理を行います。
	before(:all) do
		@model = Post
		@value = 0
	end

	# 各テスト毎に初期化処理を行います。
	before(:each) do
    @value += 1
    puts "before each: #{@value}"
  end

	# 各テスト毎に後処理を行います。
	after(:each) do
    @value += 1
    puts "after each: #{@value}"
    puts "posts: #{posts(:post_model1).to_yaml}"
  end

	# 対応するfixutureでの投入件数と一致していれば合格
	it "postsのデータ件数をテストします。" do
		samples = @model.all

#		samples.size().should == 1
    samples.size().should == 2
	end
end
