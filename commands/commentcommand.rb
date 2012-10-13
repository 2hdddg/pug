$:.unshift(File.expand_path('../../', __FILE__))
require "models/comment"
require "parse"

class CommentCommand
	def initialize(repository)
		@repository = repository
	end

	def run(parameters, input_callback, output_callback)
		filename = parameters.shift
		modelToCommentOn = @repository.get(filename)

		model = Comment.new()
		# set fields on model from parameters
		while parameters.length > 0
			option = parameters.shift
			nv =  Parse.option_to_name_and_value(option)
			model.set nv[:name], nv[:value]
		end

		model.prompt input_callback

		modelToCommentOn.add_comment model
		@repository.set(modelToCommentOn, filename)
	end
end