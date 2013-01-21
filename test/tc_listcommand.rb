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
		command = Commands::ListCommand.new(fake, nil, nil)
		invoke = {
			:argv   => [],
			:prompt => lambda {|name, desc, default| default },
			:output => lambda {|o| bugs.push(o)},
		}

		command.run invoke

		assert_equal(1, bugs.length)
		assert(bugs[0].include?('A bug'))
	end

end
