$:.unshift(File.dirname(__FILE__))

class Model
	# required fields
	attr_accessor :title, :status

	def initialize
		@title = ''
		@status = ''
	end

	def set(name, value)
		instance_variable_set '@' + name, value
	end
end
