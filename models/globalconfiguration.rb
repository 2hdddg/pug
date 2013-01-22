$:.unshift(File.dirname(__FILE__))
require "model"

module Models

	class GlobalConfiguration < AbstractModel
		attr_accessor :repository_dir

		def initialize
			super
			@repository_dir = ''
		end
		
		def get_prompt_fields
			super() << 
				PromptField.new('repository_dir', 'Enter the directory where bugs and stuff will be placed', '')
		end
	end
end