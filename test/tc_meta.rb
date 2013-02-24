require 'test/unit'

#root = File.expand_path('../../', __FILE__)
#$:.unshift(root)
require 'meta'
# include all commands
#Dir[root + "/commands/*.rb"].each {|file| require file }


class TestMeta < Test::Unit::TestCase

	def test_can_init_addcommand_class_from_string
		command = Meta::command_from_name('Add', nil)
		
		assert_equal('Commands::AddCommand', command.class.name)
	end

	def test_can_init_addcommand_class_from_lowercase_string
		command = Meta::command_from_name('add', nil)
		
		assert_equal('Commands::AddCommand', command.class.name)
	end

	def test_returns_nil_when_command_class_not_found
		command = Meta::command_from_name('xxxxxx', nil)

		assert_equal(nil, command)
	end

	def test_can_get_list_of_commands
		commands = Meta::list_of_commands()

		assert_operator commands.length, :>, 0
	end
end
