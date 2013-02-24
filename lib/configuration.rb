require "yaml"

#$:.unshift(File.dirname(__FILE__))

class GlobalConfiguration
	attr_accessor :pugspath

	def initialize
		@pugspath = ''
	end
end

class Configuration
	def initialize(path)
		@path = path
	end

	def _globalconfiguration_filename()
		File.join(@path, '.pug_global')
	end

	def has_globalconfiguration?
		File.exists?(_globalconfiguration_filename)
	end

	def set_globalconfiguration(model)
		content = model.to_yaml
		begin
			file = File.new(_globalconfiguration_filename, 'w')
			file.write(content)
		ensure
			file.close
		end

		if !Dir.exists?(model.pugspath)
			Dir.mkdir(model.pugspath)
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