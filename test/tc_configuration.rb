require "test/unit"
require "fileutils"

$:.unshift(File.expand_path('../../', __FILE__))

require "configuration"

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

	def test_can_report_globalconfiguration_is_missing()
		configuration = Configuration.new(path_to_test_directory)

		assert_equal(false, configuration.has_globalconfiguration?)
	end

	def test_can_persist_globalconfiguration()
		configuration = Configuration.new(path_to_test_directory)
		globalconfiguration = GlobalConfiguration.new()
		globalconfiguration.pugspath = File.join(path_to_test_directory, 'xxx')

		configuration.set_globalconfiguration(globalconfiguration)

		another_configuration = Configuration.new(path_to_test_directory)
		persisted = another_configuration.get_globalconfiguration

		assert_equal(persisted.pugspath, globalconfiguration.pugspath)
	end

	def test_should_create_directory_for_pugs_if_not_exists()
		configuration = Configuration.new(path_to_test_directory)
		globalconfiguration = GlobalConfiguration.new()
		globalconfiguration.pugspath = File.join(path_to_test_directory, 'xxx')

		configuration.set_globalconfiguration(globalconfiguration)


		assert(Dir.exists?(globalconfiguration.pugspath), 'Should have created directory for pugs')
	end
end
