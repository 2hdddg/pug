$:.unshift(File.expand_path('../../', __FILE__))
require "models/comment"
require "parse"

module Commands

	class CommentCommand
		def initialize(repository, userconfiguration, globalgonfiguration)
			@repository = repository
			@userconfiguration = userconfiguration
		end

		def run(commandcontext)
			filename = commandcontext.pop_argument!
			modelToCommentOn = @repository.get(filename)

			comment = Models::Comment.new()
			# tag comment with signature of user
			comment.signature = @userconfiguration.signature

			# set fields on comment from parameters
			while commandcontext.number_of_arguments > 0
				option = commandcontext.pop_argument!
				nv =  Parse.option_to_name_and_value(option)
				comment.set nv[:name], nv[:value]
			end

			comment.prompt commandcontext.prompt_as_lambda

			modelToCommentOn.add_comment comment
			@repository.set(modelToCommentOn, filename)
		end
	end

end