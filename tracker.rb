require "date"
require "find"

$:.unshift(File.dirname(__FILE__))
require "format"

class Tracked
	attr_accessor :filepath, :type, :status, :title, :filename
end

class Tracker
	attr_reader :root

	def initialize(root)
		@root = root
		raise "#{root} is not a directory" if !File.directory?root
	end

	def filename_from(title)
		nowpart = Format::compact_datetime(DateTime.now)
		titlepart = Format::safe_for_filename(title)
		filename = "#{titlepart}_#{nowpart}.txt"
	end

	def ensure_directory_exists(directory)
		Dir.mkdir(directory) if !File.directory?(directory)
	end

	def add(type, status, title)
		directory = File.join(@root, type)
		ensure_directory_exists directory
		directory = File.join(directory, status)
		ensure_directory_exists directory
		filename = filename_from(title)
		filepath = File.join(directory, filename)
		begin
			file = File.new(filepath, 'w')
			file.puts title
		ensure
			file.close
		end

		tracked = Tracked.new()
		tracked.type = type
		tracked.status = status
		tracked.title = title
		tracked.filepath = filepath
		tracked.filename = filename

		tracked
	end


	def get(type, status, filename)
		filepath = File.join(@root, type, status, filename)
		title = nil
		File.open(filepath) {|f| title = f.readline }
		title = title.gsub(/\n/, '')

		tracked = Tracked.new()
		tracked.type = type
		tracked.status = status
		tracked.filepath = filepath
		tracked.filename = filename
		tracked.title = title

		tracked
	end

	def all(type)
		rootpath = File.join(@root, type)
		return [] if !File.directory?rootpath

		found = []
		Find.find(rootpath) do |path|
			if FileTest.directory?(path)
				if File.basename(path)[0] == '.'
					Find.prune
				else
					next
				end
			else
				if File.file?(path)
					# split into parts to extract status
					parts = path.split(File::SEPARATOR).reverse
					filename = parts.shift
					status = parts.shift
					found.push(get(type, status, filename))
				else
					next
				end
			end
		end
		found
	end

	def find(type, filename)
		rootpath = File.join(@root, type)
		return nil if !File.directory?rootpath

		Find.find(rootpath) do |path|
			if FileTest.directory?(path)
				if File.basename(path)[0] == '.'
					Find.prune
				else
					next
				end
			else
				if File.basename(path) == filename
					# split into parts to extract status
					parts = path.split(File::SEPARATOR).reverse
					parts.shift # pops filename
					status = parts.shift
					return get type, status, filename
				else
					next
				end
			end
		end
		nil
	end
end
