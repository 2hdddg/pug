$:.unshift(File.dirname(__FILE__))

class AbstractModel
	def set(name, value)
		instance_variable_set '@' + name, value
	end

	def get(name)
		instance_variable_get '@' + name
	end

	def get_prompt_fields
		[]
	end

	def prompt(prompt_callback)
		fields = get_prompt_fields()
		fields.each do |f|
			value = get(f.name)
			if value == ''
				set(f.name, prompt_callback.call(f.name, f.prompt, ''))
			end
		end
	end
end

# Base class for models that will be persisted as roots
class Model < AbstractModel
	attr_accessor :title, :comments

	def initialize
		@title = ''
		@comments = []
	end

	def get_prompt_fields
		[PromptField.new('title', 'Please enter title')]
	end

	def add_comment(comment)
		@comments = [] if @comments == nil
		@comments << comment
	end	
end

