$:.unshift(File.dirname(__FILE__))

class Comment < AbstractModel
	attr_accessor :text

	def initialize
		@text = ''
	end

	def get_fields
		[PromptField.new('text', 'Please enter your comment')]
	end
end