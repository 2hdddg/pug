$:.unshift(File.expand_path('../../', __FILE__))
require "meta"
require "parse"

module Commands

	class AddCommand
		def initialize(repository, userconfiguration, globalgonfiguration)
			@repository = repository
		end

		def run(commandcontext)
			classname = commandcontext.pop_argument!  #invoke[:argv].shift
			model = Meta::model_from_classname(classname)

			# set fields on model from parameters
			while commandcontext.number_of_arguments > 0
				option = commandcontext.pop_argument!
				nv =  Parse.option_to_name_and_value(option)
				model.set nv[:name], nv[:value]
			end

			# let the model prompt for additional fields 
			model.prompt commandcontext.prompt_as_lambda

			@repository.add(model)
		end

		def help(commandcontext)
			commandcontext.output 'hello'
		end
	end
end