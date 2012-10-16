$:.unshift(File.dirname(__FILE__))
require "model"

class UserConfiguration < AbstractModel
	attr_accessor :signature

	def initialize
		super
		@signature = ''
	end
	
	def get_prompt_fields
		super() << 
			PromptField.new('signature', 'Please enter your signature', '')
	end
end