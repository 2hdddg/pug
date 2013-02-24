require 'test/unit'

#$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/commandcontext'
require 'commands/helpcommand'

class TestHelpCommand < Test::Unit::TestCase
	
	def setup
		@errors = []
		@onerror = lambda {|e| @errors.push(e)}
		exited = false
		@onexit = lambda {|c| exited = true }
		@prompts = []
		@onprompt = lambda {|text| 
			@prompts.push(text)
			'A title'
		}
		@outputs = []
		@onoutput = lambda {|text|
			@outputs.push(text)
		}
		@tracker = FakeTracker.new
	end
	
	class FakeTracker
		attr_reader :added

		def initialize
			@added = []
		end

		def add(type, status, title)
			@added.push({:type => type, :status => status, :title => title})
		end
	end

	def test_run_should_output_names_of_all_commands_when_no_additional_parameters
		command = Commands::HelpCommand.new(@tracker)
		commandcontext = Commands::CommandContext.new([], @onerror, @onoutput, @onprompt, @onexit)

		command.run commandcontext

		assert_operator @outputs.length, :>, 0
	end
end