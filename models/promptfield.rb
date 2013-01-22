$:.unshift(File.dirname(__FILE__))

module Models

	class PromptField
		attr_accessor :name, :prompttext, :default, :options

		def initialize(name, prompttext, default = nil, options = nil)
			@name = name
			@prompttext = prompttext
			@default = default || ''
			@options = options
		end

		def expand(value)
			if @options != nil
				matched = @options.select {|o| 
					o[:short].downcase == value.to_s.downcase ||
					o[:long].downcase == value.to_s.downcase
				}
				if matched.count > 0
					matched[0][:long]
				else
					default
				end
			else
				value
			end
		end

		def options_prompt_texts
			@options.map {|o| "#{o[:long]}(#{o[:short]})"}
		end

		def prompt
			p = @prompttext
			p = p + " ('#{@default}' is default)" if @default != nil and @default != ''
			p = p + "\n One of " + options_prompt_texts.join(', 	') if @options != nil
			p
		end
	end
end