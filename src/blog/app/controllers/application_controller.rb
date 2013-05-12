# 共通コントローラー
# 共通処理や初期化処理をまとめています。

class ApplicationController < ActionController::Base
	protect_from_forgery

	@@_logger = nil

	before_filter 	:__init, :__before
	after_filter 	:__after

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
#    	log4r_config = YAML.load_file(File.join(File.dirname(__FILE__),"log4r.yml"))
#    	YamlConfigurator.decode_yaml(log4r_config['log4r_config'])
#    	config.logger = Log4r::Logger[Rails.env]
#    	config.logger = Log4r::Logger['publicweb']

	    # YamlConfiguratorがうまく使えなくなったので直書きに変更
    	@@_logger = Log4r::Logger.new(initlog)
	    @@_logger.outputters = Log4r::FileOutputter.new (
    	    "publicweb",
        	:filename   => "#{Rails.root}/log/publicweb.log",
	        :maxsize    => 10000000,   # 10M bytes
    	    :formatter  => Log4r::PatternFormatter.new (
        	    :pattern        => "%d %C [%l]: %M",
            	:date_format    => "%Y/%m/%d %H:%M:%S"
    	    )
	    )
	    @@_logger.level = Log4r::DEBUG
    	@@_logger.trace = true
    end

    # SQLログの出力設定を行います。
    def __inisqllog(initlog = Logger.new(STDOUT))
    	ActiveRecord::Base.logger = initlog
    end

end
