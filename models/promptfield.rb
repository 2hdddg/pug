$:.unshift(File.dirname(__FILE__))

class PromptField
	attr_accessor :name, :prompt

	def initialize(name, prompt)
		@name = name
		@prompt = prompt
	end
end
