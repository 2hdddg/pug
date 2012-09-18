require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))
require 'meta'

class TestMeta < Test::Unit::TestCase
	
	def test_model_from_classname_can_create_bug
		model = Meta::model_from_classname('Bug')

		assert_equal('Bug', model.class.name)
	end

end
