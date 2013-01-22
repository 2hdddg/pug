$:.unshift(File.expand_path('../../', __FILE__))

module Commands
	class CommandContext
		attr_accessor :output_lambda, :prompt_lambda

		def initialize(arguments, output, prompt)
			@arguments = arguments
			@output_lambda = output
			@prompt_lambda = prompt
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
			@prompt_lambda.call(field, text, defaultvalue)
		end

		def prompt_as_lambda
			lambda {|field, text, defaultvalue| prompt field, text, defaultvalue }
		end
	end
end