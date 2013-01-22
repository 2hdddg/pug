$:.unshift(File.dirname(__FILE__))

module Models
	class Comment < AbstractModel
		attr_accessor :text, :signature

		def initialize
			@text = ''
		end

		def get_prompt_fields
			[PromptField.new('text', 'Please enter your comment')]
		end
	end
end