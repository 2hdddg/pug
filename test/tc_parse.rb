require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'parse'

class TestParse < Test::Unit::TestCase
	
	def test_option_to_name_and_value_should_parse
		option = "--title=xxx"

		parsed = Parse::option_to_name_and_value(option)

		assert_equal('xxx', parsed[:value])
	end

	def test_option_to_name_and_value_should_parse_when_quoted
		option = '--title="xxx yyy"'

		parsed = Parse::option_to_name_and_value(option)

		assert_equal('xxx yyy', parsed[:value])
	end

end
