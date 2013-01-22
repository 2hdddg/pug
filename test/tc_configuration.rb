require "test/unit"
require "fileutils"

File.expand_path('../', __FILE__)

require "configuration"
require "models/userconfiguration"
require "models/globalconfiguration"

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
		userconfiguration = Models::UserConfiguration.new()
		userconfiguration.signature = '2hdddg'

		configuration.set_userconfiguration(userconfiguration)

		another_configuration = Configuration.new(path_to_test_directory)
		persisted = another_configuration.get_userconfiguration

		assert_equal(persisted.signature, userconfiguration.signature)
	end

	def test_can_report_globalconfiguration_is_missing()
		configuration = Configuration.new(path_to_test_directory)

		assert_equal(false, configuration.has_globalconfiguration?)
	end

	def test_can_persist_globalconfiguration()
		configuration = Configuration.new(path_to_test_directory)
		globalconfiguration = Models::GlobalConfiguration.new()
		globalconfiguration.repository_dir = File.join(path_to_test_directory, 'xxx')

		configuration.set_globalconfiguration(globalconfiguration)

		another_configuration = Configuration.new(path_to_test_directory)
		persisted = another_configuration.get_globalconfiguration

		assert_equal(persisted.repository_dir, globalconfiguration.repository_dir)
	end

	def test_should_create_directory_for_repository_if_not_exists()
		configuration = Configuration.new(path_to_test_directory)
		globalconfiguration = Models::GlobalConfiguration.new()
		globalconfiguration.repository_dir = File.join(path_to_test_directory, 'xxx')

		configuration.set_globalconfiguration(globalconfiguration)


		assert(Dir.exists?(globalconfiguration.repository_dir), 'Should have created directory for repository')

	end
end
