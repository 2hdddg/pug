$:.unshift(File.dirname(__FILE__))

class PromptField
	attr_accessor :name, :prompt, :default, :options

	def initialize(name, prompt, default = nil, options = nil)
		@name = name
		@prompt = prompt
		@default = default || ''
		@options = options
	end

	def expand(value)
		if @options != nil
			matched = @options.select {|o| o[:short] == value }
			if matched.count > 0
				matched[0][:long]
			end
			default
		else
			value
		end
	end
end