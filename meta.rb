
$:.unshift(File.dirname(__FILE__))

module Meta
	def Meta.model_from_classname(classname)
		Object.const_get(classname.capitalize).new
	end

	def Meta.command_from_name(commandname, repository)
		begin
			klass = Object.const_get(commandname.capitalize + 'Command')
			klass.new repository
		rescue NameError
			nil
		end
	end
end