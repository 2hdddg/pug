
module Filedifferences
	def self.get_filenames(path)
		Dir.glob(File.join(path, '*.yml')).map {|f| File.basename(f)}
	end

	def self.get(first_path, second_path)

		first_files = self::get_filenames(first_path)
		second_files = self::get_filenames(second_path)

		{ 
			:in_both => first_files & second_files,
			:only_in_first => first_files - second_files,
			:only_in_second => second_files - first_files
		}
	end
end
