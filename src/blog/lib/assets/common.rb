# 共通ライブラリ
# アプリケーション全体で使用する共通処理を行います。

class Common

	# 初期化処理を行います。
	def initialize
	end

	# 実行中関数を返します。
    def self.function_name
  		# 正規表現は、Rubyのリファレンスのものを拝借してます。
  		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller.first
    		return $3
		end
	end

	# controllerとactionを除いたパラメータを返します。
	# @param  [Array] params controllerのparamsを渡してください
	# @return [Array] paramsからcontrollerとactionを除いた値
	def self.getparams(params)
		params.delete("controller")
		params.delete("action")
		return params
	end
end