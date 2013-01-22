
$:.unshift(File.dirname(__FILE__))

module Meta

	def Meta.model_from_classname(classname)
		Object.const_get(classname.capitalize).new
	end

	def Meta.command_from_name(commandname, repository, userconfiguration, globalconfiguration)
		begin
			klass = Commands.const_get(commandname.capitalize + 'Command')
			klass.new repository, userconfiguration, globalconfiguration
		rescue NameError
			nil
		end
	end

	def Meta.list_of_commands()
		Commands.constants.select{|x| x =~ /Command$/ }.map{|c| c.to_s.gsub /Command$/, '' }
	end
end