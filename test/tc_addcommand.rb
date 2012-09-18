require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/addcommand'

class TestAddCommand < Test::Unit::TestCase
	
	class FakeRepository
		attr_reader :added

		def initialize
			@added = []
		end

		def add(model)
			@added.push(model)
		end
	end

	def test_run_should_add_bug_to_repository
		fake = FakeRepository.new
		command = AddCommand.new(fake)
		command.run ["Bug", "--title=\"A new bug\""]

		assert_equal(1, fake.added.length)
		assert_equal('A new bug', fake.added[0].title)
	end
end
