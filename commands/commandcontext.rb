$:.unshift(File.expand_path('../../', __FILE__))
require 'time'
require "commands/headlesscommandcontext"

module Commands
	class CommandContext
		attr_accessor :output_lambda, :prompt_lambda, :now_lambda

		def initialize(arguments, output, prompt)
			@arguments = arguments
			@headless = (@arguments.any? { |arg| arg=='--headless' })
			@output_lambda = output
			@prompt_lambda = prompt
			@now_lambda = lambda {|| DateTime.now }
		end

		def pop_argument!
			@arguments.shift
		end

		def number_of_arguments
			@arguments.length
		end

		def output(s)
			@output_lambda.call(s)
		end

		def prompt(field, text, defaultvalue)
			if @headless
				raise HeadLessCommandContextException.new()
			end
			@prompt_lambda.call(field, text, defaultvalue)
		end

		def prompt_as_lambda
			lambda {|field, text, defaultvalue| prompt field, text, defaultvalue }
		end

		def get_now
			@now_lambda.call
		end
	end
	
end