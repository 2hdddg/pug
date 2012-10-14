
module DirCompare
	def DirCompare.get_filenames(path)
		Dir.glob(File.join(path, '*.yml')).map {|f| File.basename(f)}
	end

	def DirCompare.compare(first_path, second_path)

		first_files = DirCompare::get_filenames(first_path)
		second_files = DirCompare::get_filenames(second_path)

		{ 
			:in_both => first_files & second_files,
			:only_in_first => first_files - second_files,
			:only_in_second => second_files - first_files
		}
	end
end
