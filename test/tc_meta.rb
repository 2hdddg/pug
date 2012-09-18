require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'meta'

class TestMeta < Test::Unit::TestCase
	
	def test_can_init_bug_class_from_string
		model = Meta::model_from_classname('Bug')

		assert_equal('Bug', model.class.name)
	end

	def test_can_init_bug_class_from_lowercase_string
		model = Meta::model_from_classname('bug')

		assert_equal('Bug', model.class.name)
	end

	def test_can_init_addcommand_class_from_string
		command = Meta::command_from_name('Add', nil)
		
		assert_equal('AddCommand', command.class.name)
	end

	def test_can_init_addcommand_class_from_lowercase_string
		command = Meta::command_from_name('add', nil)
		
		assert_equal('AddCommand', command.class.name)
	end
end
