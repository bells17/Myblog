# 共通コントローラー
# 共通処理や初期化処理をまとめています。

class ApplicationController < ActionController::Base
	protect_from_forgery

	@@_logger = nil

	before_filter 	:__init
	before_filter 	:__before

	after_filter 		:__after

	protected

	# 初期化処理を行います。
	def __init
		__initlog('publicweb')
		__inisqllog(@@_logger)
		@@_logger.debug("start\n" +
						"Request: \"#{request.url}\" " +
						"controller: \"#{params[:controller]}\" action: \"#{params[:action]}\"")
	end

	# 前処理を行います。
	def __before
		@@_logger.debug(Common.function_name + " called")
	end

	# 後処理を行います。
	def __after
		@@_logger.debug(Common.function_name + " called")
		@@_logger.debug('end');
	end


	# log設定を行います。
	def __initlog(initlog = Rails.env)
		# assign log4r's logger as rails' logger.
# 		Log4r::YamlConfigurator.load_yaml_file("#{Rails.root}/config/log4r.yml")
# 		@@_logger = Log4r::Logger.new(initlog)

		# yamlがうまく設定できないので直書き
		logfile="#{Rails.root}/log/publicweb.log"
		formatter = Log4r::PatternFormatter.new(
			:maxsize    	=> 10000000,
		  :pattern 			=> "%d %C [%l]: %M",
		  :date_format 	=> "%Y/%m/%d %H:%M:%S"
		)
		@@_logger = Log4r::Logger.new(initlog)
		outputter = Log4r::FileOutputter.new(
		  "file",
		  :filename 	=> logfile,
		  :formatter 	=> formatter
		)
		@@_logger.add(outputter)
		@@_logger.level = Log4r::DEBUG
		@@_logger.trace = true

  end

  # SQLログの出力設定を行います。
  def __inisqllog(initlog = Logger.new(STDOUT))
  	ActiveRecord::Base.logger = initlog
  end

end
