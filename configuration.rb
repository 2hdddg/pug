require "yaml"

$:.unshift(File.dirname(__FILE__))

class Configuration
	def initialize(path)
		@path = path
	end

	def _userconfiguration_filename()
		File.join(@path, '.todo_user')
	end

	def _globalconfiguration_filename()
		File.join(@path, '.todo_global')
	end

	def has_userconfiguration?
		File.exists?(_userconfiguration_filename)
	end

	def has_globalconfiguration?
		File.exists?(_globalconfiguration_filename)
	end

	def set_userconfiguration(model)
		content = model.to_yaml
		begin
			file = File.new(_userconfiguration_filename, 'w')
			file.write(content)
		ensure
			file.close
		end
	end

	def set_globalconfiguration(model)
		content = model.to_yaml
		begin
			file = File.new(_globalconfiguration_filename, 'w')
			file.write(content)
		ensure
			file.close
		end
	end

	def get_userconfiguration()
		begin
			file = File.open(_userconfiguration_filename)
		   	model = YAML::load(file) if file != nil
			model
		ensure
			file.close if file != nil
		end 
	end

	def get_globalconfiguration()
		begin
			file = File.open(_globalconfiguration_filename)
			model = YAML::load(file) if file != nil
			model
		ensure
			file.close if file != nil
		end
	end
end