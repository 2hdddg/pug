require "test/unit"

File.expand_path('../', __FILE__)
require 'models/bug'

class TestBug < Test::Unit::TestCase
	def test_validate_should_require_status_field
		required_status = false
		missing_callback = lambda do |field, description, default|
			required_status = true if field == 'status'
			'abc'
		end 
		model = Bug.new
		model.validate missing_callback

		assert_equal(true, required_status)
	end
end
	