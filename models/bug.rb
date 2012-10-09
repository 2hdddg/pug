$:.unshift(File.dirname(__FILE__))
require "model"

class Bug < Model
	# required fields
	attr_accessor :status

	def initialize
		super
		@status = ''
	end

	def get_fields
		super() << PromptField.new('status', "Please enter initial status")
	end
end
