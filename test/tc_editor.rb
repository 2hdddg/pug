require "test/unit"
require "fileutils"

#$:.unshift(File.expand_path('../../', __FILE__))
require 'editor'

class TestEditor < Test::Unit::TestCase

	def setup
	end

	def teardown
	end

	def test_is_configured_is_true_when_editor_is_configured
		editor = Editor.new({ "PUG_EDITOR" => 'something'})
		assert_equal true, editor.is_configured
	end


end