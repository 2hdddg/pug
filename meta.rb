
$:.unshift(File.dirname(__FILE__))

module Meta
	def Meta.model_from_classname(classname)
		Object.const_get(classname.capitalize).new
	end

	def Meta.command_from_name(commandname, repository)
		Object.const_get(commandname.capitalize + 'Command').new repository
	end
end