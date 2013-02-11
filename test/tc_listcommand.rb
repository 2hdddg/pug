require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require "models/bug"
require "commands/listcommand"
require "models/userconfiguration"
require "models/globalconfiguration"

class TestListCommand < Test::Unit::TestCase
	
	class FakeRepository

		def all
			bugs = []
			bug = Models::Bug.new
			bug.title = 'A bug'
			bugs.push(bug)
			bugs.map {|b| yield 'file', b}
		end
	end

	def test_run_should_output_title_of_all_bugs
		bugs = []
		fake = FakeRepository.new
		userconfiguration = Models::UserConfiguration.new
		globalconfiguration = Models::GlobalConfiguration.new
		globalconfiguration.template_dir = './templates'
		listcommand = Commands::ListCommand.new(fake, userconfiguration, globalconfiguration)
		commandcontext = Commands::CommandContext.new(['add'], lambda {|o| bugs.push(o)}, lambda {|name, desc, default| default })

		listcommand.run commandcontext

		found = bugs.first {|b| b.include?('A bug') }
		assert(found != nil)
	end
end
