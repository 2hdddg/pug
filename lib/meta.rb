
module Meta

	def Meta.command_from_name(commandname, tracker)
		begin
			klass = Commands.const_get(commandname.capitalize + 'Command')
			klass.new tracker
		rescue NameError
			nil
		end
	end

	def Meta.list_of_commands()
		Commands.constants.select{|x| x =~ /Command$/ }.map{|c| c.to_s.gsub /Command$/, '' }
	end
end