$:.unshift(File.expand_path('../../', __FILE__))

module Commands
	class CommandContext
		def initialize(arguments, output, prompt)
			@arguments = arguments
			@output = output
			@prompt = prompt
		end

		def pop_argument!
			@arguments.shift
		end

		def number_of_arguments
			@arguments.length
		end

		def output(s)
			@output.call(s)
		end

		def prompt(field, text, defaultvalue)
			@prompt.call(field, text, defaultvalue)
		end

		def prompt_as_lambda
			lambda {|field, text, defaultvalue| prompt field, text, defaultvalue }
		end
	end
end