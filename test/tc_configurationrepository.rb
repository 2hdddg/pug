require "test/unit"
require "fileutils"

File.expand_path('../', __FILE__)

require 'configurationrepository'
require "models/userconfiguration"

class TestConfigurationRepository < Test::Unit::TestCase
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
		repository = ConfigurationRepository.new(path_to_test_directory)

		assert_equal(false, repository.has_userconfiguration?)
	end

	def test_can_persist_userconfiguration()
		repository = ConfigurationRepository.new(path_to_test_directory)
		userconfiguration = UserConfiguration.new()
		userconfiguration.signature = '2hdddg'

		repository.set_userconfiguration(userconfiguration)

		another_repository = ConfigurationRepository.new(path_to_test_directory)
		persisted = another_repository.get_userconfiguration

		assert_equal(persisted.signature, userconfiguration.signature)
	end
end
