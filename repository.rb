require "date"
require "yaml"

$:.unshift(File.dirname(__FILE__))
require "format"
Dir["models/*.rb"].each {|file| require file }

class Repository
	attr_reader :path

	def initialize(path)
		@path = path
	end

	def get_path_and_filename(model)
		nowpart = Format::compact_datetime(DateTime.now)
		titlepart = Format::safe_for_filename(model.title)
		filename = "#{titlepart}_#{nowpart}.yml"
		File.join(@path, filename)
	end

	def add(model)
		content = model.to_yaml
		path_and_filename = get_path_and_filename(model)
		file = File.new(path_and_filename, 'w')
		file.write(content)
		file.close
		path_and_filename
	end

	def all
		files = Dir.glob(File.join(@path, '*.yml'))
		files.map { |f| yield f, get(f) }
	end

	def get(filename)
		filename = File.join(@path, filename) if not filename.include?(@path)
		file = File.open(filename)
		d = YAML::load(file)
		file.close
		d		
	end

	def set(model, filename)
		content = model.to_yaml
		path_and_filename = filename #File.join(@path, filename)
		file = File.new(path_and_filename, 'w')
		file.write(content)
		file.close
	end
end
