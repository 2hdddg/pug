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

	def test_add_should_persist_model
		repository = Repository.new(path_to_test_directory)
		bug = Models::Bug.new
		bug.title = 'A new bug'

		repository.add(bug)

		all = repository.all { |f, d|  d } 
		assert_equal(all.length, 1)
		assert_equal('Models::Bug', all[0].class.name)
		assert_equal('A new bug', all[0].title)	
	end

	def test_all_should_yield_filename_and_model
		repository = Repository.new(path_to_test_directory)
		bug1 = Models::Bug.new
		bug1.title = 'A new bug'
		bug2 = Models::Bug.new
		bug2.title = 'Another bug'
		filename1 = repository.add(bug1)
		filename2 = repository.add(bug2)

		all = repository.all { |f, m| {:f => f, :m => m}}

		assert_equal(2, all.length)
		assert(all.any? {|x| x[:f] == filename1 } )
		assert(all.any? {|x| x[:m].title == bug2.title } )
	end

	def test_get_should_retrive_model
		repository = Repository.new(path_to_test_directory)
		bug = Models::Bug.new
		bug.title = 'A new bug'
		filename = repository.add(bug)

		bug = repository.get(filename)
		
		assert_equal('Models::Bug', bug.class.name)
		assert_equal('A new bug', bug.title)			
	end

	def test_set_should_persist_changes
		repository = Repository.new(path_to_test_directory)
		bug = Models::Bug.new
		bug.title = 'A new bug'
		filename = repository.add(bug)
		bug = repository.get(filename)
		bug.status = 'weird'
	
		repository.set(bug, filename)

		bug = repository.get(filename)
		assert_equal('weird', bug.status)	
	end
end