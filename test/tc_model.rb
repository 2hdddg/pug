require "test/unit"

File.expand_path('../', __FILE__)
require 'models/model'

class TestModel < Test::Unit::TestCase

	def test_set_should_set_properties
		model = Model.new
		model.set 'title', 'a title'

		assert_equal('a title', model.title)
	end
end
