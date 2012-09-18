require "date"
require "yaml"

$:.unshift(File.dirname(__FILE__))
require "format"
Dir["models/*.rb"].each {|file| require file }

class Repository
	def initialize(path)
		@path = path
	end

	def get_path_and_filename(model)
		filename = 
			Format::compact_datetime(DateTime.now) +
			'_' +
			Format::safe_for_filename(model.title) +
			'.yml'
		File.join(@path, filename)
	end

	def add(model)
		content = model.to_yaml
		path_and_filename = get_path_and_filename(model)
		file = File.new(path_and_filename, 'w')
		file.write(content)
		file.close
	end

	def all
		files = Dir.glob(File.join(@path, '*.yml'))
		files.map { |f| yield f, get(f) }
	end

	def get(filename)
		file = File.open(filename)
		d = YAML::load(file)
		file.close
		d		
	end
end
