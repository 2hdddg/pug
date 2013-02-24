require "test/unit"
require "fileutils"

#$:.unshift(File.expand_path('../../', __FILE__))
require 'tracker'

class TestTracker < Test::Unit::TestCase
	def path_to_test_directory
		File.join(Dir.pwd, 'TestPugs')
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

	def test_add_creates_directory_for_type
		tracker = Tracker.new(path_to_test_directory)

		tracker.add('Bug', 'Reported', 'The title')

		assert_equal File.directory?(File.join(path_to_test_directory, 'Bug')), true
	end

	def test_add_creates_directory_for_status
		tracker = Tracker.new(path_to_test_directory)

		tracker.add('Bug', 'Reported', 'The title')

		assert_equal File.directory?(File.join(path_to_test_directory, 'Bug', 'Reported')), true
	end

	def test_add_creates_a_file
		tracker = Tracker.new(path_to_test_directory)

		tracked = tracker.add('Bug', 'Reported', 'The title')

		assert_equal File.exists?(tracked.filepath), true
	end

	def test_get_has_properties_properly_set
		tracker = Tracker.new(path_to_test_directory)
		tracked = tracker.add('Bug', 'Reported', 'The title')

		getted = tracker.get('Bug', 'Reported', tracked.filename)

		assert_equal getted.type, 'Bug'
		assert_equal getted.status, 'Reported'
		assert_equal getted.filename, tracked.filename
		assert_equal getted.title, 'The title'
	end

	def test_can_parse_title_when_more_content_has_been_added
		tracker = Tracker.new(path_to_test_directory)
		tracked = tracker.add('Bug', 'Reported', 'The title')
		file = File.open(tracked.filepath, "a")
		file.puts "ab"
		file.puts ""
		file.puts "cd"
		file.close

		getted = tracker.get('Bug', 'Reported', tracked.filename)

		assert_equal 'The title', getted.title
	end

	def test_find_can_find_by_filename_when_status_is_same
		tracker = Tracker.new(path_to_test_directory)
		tracked = tracker.add('Bug', 'Reported', 'The title')

		found = tracker.find('Bug', tracked.filename)

		assert_equal tracked.filepath, found.filepath
	end

	def test_find_returns_nil_when_not_found
		tracker = Tracker.new(path_to_test_directory)
		tracker.add('Bug', 'Closed', 'just to make sure dirs created')

		found = tracker.find('Bug', 'not_found')

		assert_equal nil, found
	end

	def test_find_can_find_by_filename_when_status_has_changed
		tracker = Tracker.new(path_to_test_directory)
		tracker.add('Bug', 'Closed', 'just to make sure dirs created')
		tracked = tracker.add('Bug', 'Reported', 'The title')
		FileUtils.mv tracked.filepath, File.join(path_to_test_directory, 'Bug', 'Closed', tracked.filename)

		found = tracker.find('Bug', tracked.filename)

		assert_equal tracked.filename, found.filename
		assert_equal tracked.type, found.type
		assert_equal 'Closed', found.status
	end

	def test_find_should_return_nil_when_directory_for_type_does_not_exit
		tracker = Tracker.new(path_to_test_directory)

		found = tracker.find('Bug', 'something')

		assert_equal nil, found
	end

	def test_all_returns_all_of_specified_type
		tracker = Tracker.new(path_to_test_directory)
		tracked = tracker.add('Bug', 'Reported', 'First')
		tracked = tracker.add('Bug', 'Reported', 'Second')

		found = []
		tracker.all('Bug') {|b| found.push(b)}

		assert_equal 2, found.count
	end

	def test_all_returns_empty_array_when_directory_for_type_does_not_exist
		tracker = Tracker.new(path_to_test_directory)

		found = []
		tracker.all('Bug') {|b| found.push(b)}

		assert_equal 0, found.length
	end
end