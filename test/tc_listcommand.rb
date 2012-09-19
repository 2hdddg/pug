require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require "models/bug"
require 'commands/listcommand'

class TestListCommand < Test::Unit::TestCase
	
	class FakeRepository
		def all
			bug = Bug.new
			bug.title = 'A bug'
			yield 'file', bug
		end
	end

	def test_run_should_output_title_of_all_bugs
		bugs = []
		fake = FakeRepository.new
		input_callback = lambda {|name, desc, default| default }
		output_callback = lambda {|o| bugs.push(o)}
		command = ListCommand.new(fake)
		command.run [], input_callback, output_callback

		assert_equal(1, bugs.length)
		assert_equal('A bug', bugs[0].slice(0, 5))
	end

end
