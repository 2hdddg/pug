$:.unshift(File.expand_path('../../', __FILE__))
require "models/comment"
require "parse"

class CommentCommand
	def initialize(repository)
		@repository = repository
	end

	def run(invoke)
		filename = invoke[:argv].shift
		modelToCommentOn = @repository.get(filename)

		model = Comment.new()
		# set fields on model from parameters
		while invoke[:argv].length > 0
			option = invoke[:argv].shift
			nv =  Parse.option_to_name_and_value(option)
			model.set nv[:name], nv[:value]
		end

		model.prompt invoke[:prompt]

		modelToCommentOn.add_comment model
		@repository.set(modelToCommentOn, filename)
	end
end