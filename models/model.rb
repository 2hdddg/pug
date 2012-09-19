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

	def validate(missing_field_callback)
		@title = missing_field_callback.call('title', 'Title', '') if @title == ''
		@status = missing_field_callback.call('status', 'Status', '') if @status == ''
	end
end
