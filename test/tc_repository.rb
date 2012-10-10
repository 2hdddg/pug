require "test/unit"
require "fileutils"

File.expand_path('../', __FILE__)
require 'models/bug'
require 'repository'

class TestRepository < Test::Unit::TestCase
	def path_to_test_directory
		File.join(Dir.pwd, 'TestRepository')
	end

	def setup
		if Dir.exists?(path_to_test_directory)
			FileUtils.rm_rf(path_to_test_directory)
		end
		Dir.mkdir(path_to_test_directory)
	end

	def teardown
		FileUtils.rm_rf(path_to_test_directory)
	end

	def test_add_should_persist_bug()
		repository = Repository.new(path_to_test_directory)
		bug = Bug.new
		bug.title = 'A new bug'

		repository.add(bug)

		all = repository.all { |f, d|  d } 
		assert_equal(all.length, 1)
		assert_equal('Bug', all[0].class.name)
		assert_equal('A new bug', all[0].title)	
	end

	def test_get_should_retrive_bug
		repository = Repository.new(path_to_test_directory)
		bug = Bug.new
		bug.title = 'A new bug'
		repository.add(bug)
		filenames = repository.all { |f, d|  f } 
		filename = filenames[0]

		bug = repository.get(filename)
		
		assert_equal('Bug', bug.class.name)
		assert_equal('A new bug', bug.title)			
	end

	def test_set_should_persist_changes()
	end

end