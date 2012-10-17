require 'test/unit'

$:.unshift(File.expand_path('../../', __FILE__))

require "differences"

class TestDifferences < Test::Unit::TestCase
	class FakeRepository
		attr_accessor :to_get, :path

		def initialize
			@path = 'bbb'
		end

		def get(filename)
			@to_get
		end
	end

	def test_should_detect_added_model()
		filedifferences = { :only_in_first =>  ['x'], :in_both => [], :only_in_second => [] }
		fake1 = FakeRepository.new	
		fake1.to_get = Bug.new
		fake2 = FakeRepository.new 

		differences = Differences::get(filedifferences, fake1, fake2)

		assert_equal(:added, differences[0].name_of_difference)
	end

	def test_should_be_empty_array_when_nothing_changed()
		filedifferences = { :only_in_first =>  [], :in_both => ['x'], :only_in_second => [] }
		fake1 = FakeRepository.new	
		fake1.to_get = Bug.new
		fake2 = FakeRepository.new
		fake2.to_get = fake1.to_get 

		differences = Differences::get(filedifferences, fake1, fake2)

		assert_equal(0, differences.length)
	end

	def test_should_detect_modified_model()
		filedifferences = { :only_in_first =>  [], :in_both => ['x'], :only_in_second => [] }
		fake1 = FakeRepository.new	
		fake1.to_get = Bug.new
		fake1.to_get.title = 'to this'
		fake2 = FakeRepository.new
		fake2.to_get = Bug.new
		fake2.to_get.status = 'from this'

		differences = Differences::get(filedifferences, fake1, fake2)

		assert_equal(:modified, differences[0].name_of_difference)		
	end

	def test_should_detect_deleted_model()
		filedifferences = { :only_in_first =>  [], :in_both => [], :only_in_second => ['x'] }
		fake1 = FakeRepository.new	
		fake1.to_get = Bug.new
		fake2 = FakeRepository.new
		fake2.to_get = Bug.new
		fake2.to_get.status = 'it has been deleted'

		differences = Differences::get(filedifferences, fake1, fake2)

		assert_equal(:deleted, differences[0].name_of_difference)		
	end		

end