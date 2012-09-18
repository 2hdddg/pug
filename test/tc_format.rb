require 'test/unit'
require 'date'

$:.unshift(File.expand_path('../../', __FILE__))
require 'format'


class TestFormat < Test::Unit::TestCase
	
	def test_compact_datetime_on_2012_01_01_08_00_should_be_201201010800
		dateTime = DateTime.new(2012, 1, 1, 8, 0)

		formatted = Format::compact_datetime(dateTime)

		assert_equal('201201010800', formatted)
	end

	def test_safe_for_filename_should_remove_special_chars
		title = 'A title (123){}'

		formatted = Format::safe_for_filename(title)

		assert_equal('A_title_123', formatted)
	end
end
