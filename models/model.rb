$:.unshift(File.dirname(__FILE__))

class PromptField
	attr_accessor :name, :prompt

	def initialize(name, prompt)
		@name = name
		@prompt = prompt
	end
end

class AbstractModel
	def set(name, value)
		instance_variable_set '@' + name, value
	end

	def get(name)
		instance_variable_get '@' + name
	end

	def get_fields
		[]
	end

	def validate(missing_field_callback)
		fields = get_fields()
		fields.each do |f|
			value = get(f.name)
			if value == ''
				set(f.name, missing_field_callback.call(f.name, f.prompt, ''))
			end
		end
	end
end

class Model < AbstractModel
	attr_accessor :title, :comments

	def initialize
		@title = ''
		@comments = []
	end

	def get_fields
		[PromptField.new('title', 'Please enter title')]
	end

	def add_comment(comment)
		@comments = [] if @comments == nil
		@comments << comment
	end	
end

