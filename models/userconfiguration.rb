$:.unshift(File.dirname(__FILE__))
require "model"

module Models

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
end