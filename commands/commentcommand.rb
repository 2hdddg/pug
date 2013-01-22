$:.unshift(File.expand_path('../../', __FILE__))
require "models/comment"
require "parse"

module Commands

	class CommentCommand
		def initialize(repository, userconfiguration, globalgonfiguration)
			@repository = repository
		end

		def run(commandcontext)
			filename = commandcontext.pop_argument!  #invoke[:argv].shift
			modelToCommentOn = @repository.get(filename)

			model = Comment.new()
			# set fields on model from parameters
			while commandcontext.number_of_arguments > 0
				option = commandcontext.pop_argument!
				nv =  Parse.option_to_name_and_value(option)
				model.set nv[:name], nv[:value]
			end

			model.prompt commandcontext.prompt_as_lambda

			modelToCommentOn.add_comment model
			@repository.set(modelToCommentOn, filename)
		end
	end

end