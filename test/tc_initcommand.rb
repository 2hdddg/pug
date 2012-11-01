require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/initcommand'

class TestInitCommand < Test::Unit::TestCase
	
	class FakeConfiguration
		def set_userconfiguration(userconfiguration)
		end

		def set_globalconfiguration(globalconfiguration)
		end	
	end

end
