require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require "models/bug"
require 'commands/listcommand'

class TestListCommand < Test::Unit::TestCase
	
	class FakeRepository
		def all
			bug = Models::Bug.new
			bug.title = 'A bug'
			yield 'file', bug
		end
	end

	def test_run_should_output_title_of_all_bugs
		bugs = []
		fake = FakeRepository.new
		command = Commands::ListCommand.new(fake, nil, nil)
		commandcontext = Commands::CommandContext.new(['add'], lambda {|o| bugs.push(o)}, lambda {|name, desc, default| default })

		command.run commandcontext

		assert_equal(1, bugs.length)
		assert(bugs[0].include?('A bug'))
	end
end
