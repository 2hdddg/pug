require "test/unit"
require "fileutils"

File.expand_path('../', __FILE__)

require "configuration"
require "models/userconfiguration"

class TestConfiguration < Test::Unit::TestCase
	def path_to_test_directory
		File.join(Dir.pwd, 'TestConfigRepository')
	end

	def setup
		if Dir.exists?(path_to_test_directory)
			FileUtils.rm_rf(path_to_test_directory)
		end
		Dir.mkdir(path_to_test_directory)
	end

	def teardown
		FileUtils.rm_rf(path_to_test_directory)
	end

	def test_can_report_userconfiguration_is_missing()
		configuration = Configuration.new(path_to_test_directory)

		assert_equal(false, configuration.has_userconfiguration?)
	end

	def test_can_persist_userconfiguration()
		configuration = Configuration.new(path_to_test_directory)
		userconfiguration = UserConfiguration.new()
		userconfiguration.signature = '2hdddg'

		configuration.set_userconfiguration(userconfiguration)

		another_configuration = Configuration.new(path_to_test_directory)
		persisted = another_configuration.get_userconfiguration

		assert_equal(persisted.signature, userconfiguration.signature)
	end
end
