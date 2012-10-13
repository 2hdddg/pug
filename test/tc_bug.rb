require "test/unit"

File.expand_path('../', __FILE__)
require 'models/bug'

class TestBug < Test::Unit::TestCase
	def test_prompt_should_prompt_for_status_field
		prompted_for_status = false
		prompt_callback = lambda do |field, description, default|
			prompted_for_status = true if field == 'status'
			'abc'
		end 
		model = Bug.new
		model.prompt prompt_callback

		assert_equal(true, prompted_for_status)
	end
end
	