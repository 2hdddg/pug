$:.unshift(File.expand_path('../../', __FILE__))
require 'time'
require "commands/headlesscommandcontext"

module Commands
	class CommandContext
		attr_accessor :output_lambda, :prompt_lambda, :now_lambda

		def initialize(arguments, onerror, onoutput, onprompt, onexit)
			@arguments = arguments
			@headless = (@arguments.any? { |arg| arg == '--headless' })
			@onerror = onerror
			@onexit = onexit
			@onoutput = onoutput
			@onprompt = onprompt
			@now_lambda = lambda {|| DateTime.now }
		end

		def pop_argument!(text_when_missing = nil)
			if number_of_arguments == 0
				@onerror.call(text_when_missing)
				@onexit.call(1)
			end
			@arguments.shift
		end

		def number_of_arguments
			@arguments.length
		end

		def output(s)
			@onoutput.call(s)
		end

		def error(s)
			@onerror.call(s)
		end

		def prompt(text)
			if @headless
				raise HeadLessCommandContextException.new()
			end
			@onprompt.call(text)
		end

		#def prompt_as_lambda
		#	lambda {|field, text, defaultvalue| prompt field, text, defaultvalue }
		#end

		def get_now
			@now_lambda.call
		end


	end
end