$:.unshift(File.dirname(__FILE__))

class Modification
	attr_accessor :field, :newvalue

	def initialize(field, newvalue)
		@field = field
		@newvalue = newvalue
	end
end

class Diff
	attr_accessor :modifications

	def initialize
		@modifications = []
	end
end

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
				prompted = prompt_callback.call(f.name, f.prompt, f.default)
				expanded = f.expand(prompted)
				set(f.name, expanded)
			end
		end
	end

	def get_diff(oldmodel)
		diff = Diff.new
		diff.modifications << Modification.new('title', @title) if oldmodel.title != @title
		diff
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

	def get_summary_fields
		[{:name => "Title", :value => @title}]
	end

	def add_comment(comment)
		@comments = [] if @comments == nil
		@comments << comment
	end	
end

