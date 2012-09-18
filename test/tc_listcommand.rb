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

	def test_run_should_yield_title_of_all_bugs
		fake = FakeRepository.new
		bugs = []
		command = ListCommand.new(fake)
		command.run [] do |f|
			bugs.push(f)
		end

		assert_equal(1, bugs.length)
		assert_equal('A bug', bugs[0].slice(0, 5))
	end

end
