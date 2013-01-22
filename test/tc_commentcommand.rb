require 'test/unit'
require 'time'

$:.unshift(File.expand_path('../../', __FILE__))
require 'commands/commentcommand'

class TestCommentCommand < Test::Unit::TestCase
	class FakeRepository
		attr_accessor :to_get
		attr_accessor :has_been_set

		def get(filename)
			@to_get
		end

		def set(model, filename)
			@has_been_set = model
		end
	end

	def test_run_should_use_signature_from_user_config_to_set_signature_on_comment
		repository = FakeRepository.new
		repository.to_get = Models::Bug.new()
		userconfiguration = Models::UserConfiguration.new
		userconfiguration.signature = 'xyz'
		commentcommand = Commands::CommentCommand.new(repository, userconfiguration, nil)
		commandcontext = Commands::CommandContext.new(["the_filename"], lambda {|s| default }, lambda {|name, desc, default| default })

		commentcommand.run commandcontext

		comment = repository.has_been_set.comments[0]
		assert_equal 'xyz', comment.signature
	end

	def test_run_should_set_now_on_comment
		repository = FakeRepository.new
		repository.to_get = Models::Bug.new()
		userconfiguration = Models::UserConfiguration.new
		commentcommand = Commands::CommentCommand.new(repository, userconfiguration, nil)
		commandcontext = Commands::CommandContext.new(["the_filename"], lambda {|s| default }, lambda {|name, desc, default| default })
		now = DateTime.now
		commandcontext.now_lambda = lambda {|| now }

		commentcommand.run commandcontext

		comment = repository.has_been_set.comments[0]
		assert_equal now, comment.datetime
	end
end