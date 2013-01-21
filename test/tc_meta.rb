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
		command = Meta::command_from_name('Add', nil, nil, nil)
		
		assert_equal('Commands::AddCommand', command.class.name)
	end

	def test_can_init_addcommand_class_from_lowercase_string
		command = Meta::command_from_name('add', nil, nil, nil)
		
		assert_equal('Commands::AddCommand', command.class.name)
	end

	def test_returns_nil_when_command_class_not_found
		command = Meta::command_from_name('xxxxxx', nil, nil, nil)

		assert_equal(nil, command)
	end

	def test_can_get_list_of_commands
		commands = Meta::list_of_commands()

		assert_operator commands.length, :>, 0
	end
end
