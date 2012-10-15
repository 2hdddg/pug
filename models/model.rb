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
				prompted = prompt_callback.call(f.name, f.prompt, f.default)
				expanded = f.expand(prompted)
				set(f.name, expanded)
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

	def get_summary_fields
		[{:name => "Title", :value => @title}]
	end

	def add_comment(comment)
		@comments = [] if @comments == nil
		@comments << comment
	end	

	def get_diffs(oldmodel)
		modifications = []
		modifications << Modification.new('title', @title) if oldmodel.title != @title

		# Only report new comments
		if @comments && oldmodel.comments && @comments.length > oldmodel.comments.length
			new_comments = @comments[oldmodel.comments.length..@comments.length]
			new_comments.each {|c| modifications << NewComment.new(c) }
		elsif @comments && !oldmodel.comments
			@comments.each {|c| modifications << NewComment.new(c)}
		end

		modifications
	end

	def get_diff(oldmodel)
		modifications = get_diffs(oldmodel)

		if modifications.length > 0
			Modified.new(self, modifications)
		else
			nil
		end
	end

end

