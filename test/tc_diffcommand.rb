require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/diffcommand'
require 'models/bug'

class TestDiffCommand < Test::Unit::TestCase

	class FakeRepository
		attr_accessor :to_get, :path

		def initialize
			@path = 'bbb'
		end

		def get(filename)
			@to_get
		end
	end

	def test_should_output_added_model
		fake = FakeRepository.new
		fake.to_get = Bug.new 
		diff = nil
		output_callback = lambda {|o| diff = o }
		dircompare_callback = lambda {|f,s| { :only_in_first =>  ['x'], :in_both => [], :only_in_second => [] }}
		command = DiffCommand.new(fake)
		invoke = {
			:argv   => ['second path'],
			:output => output_callback,
			:dircompare => dircompare_callback 
		}

		command.run invoke

		assert_equal('Bug', diff.className)
	end

end
