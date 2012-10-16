require "yaml"

$:.unshift(File.dirname(__FILE__))

class Configuration
	def initialize(path)
		@path = path
	end

	def _userconfiguration_filename()
		File.join(@path, '.todo_user')
	end

	def has_userconfiguration?
		File.exists?(_userconfiguration_filename)
	end

	def set_userconfiguration(userconfiguration)
		content = userconfiguration.to_yaml
		begin
			file = File.new(_userconfiguration_filename, 'w')
			file.write(content)
		ensure
			file.close
		end
	end

	def get_userconfiguration()
		begin
			file = File.open(_userconfiguration_filename)
		   	userconfiguration = YAML::load(file) if file != nil
			userconfiguration
		ensure
			file.close if file != nil
		end 
	end
end