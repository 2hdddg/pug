
class Delta
	attr_accessor :is, :was

	def to_s
		if was == nil
			diff = "void => #{is.status}"
		elsif is == nil
			diff = "#{was.status} => void"
		else
			diff = "#{was.status} => #{is.status}"
		end
		"-#{is.title}\n" +
		"  #{diff}"
	end
end

class DeltaTracker
	def get(type, tracker_is, tracker_was)
		tracker_is.all() {|is|
			delta = Delta.new
			delta.is = is
			delta.was = tracker_was.find(is.filename)

			yield delta if is.type.downcase == type.downcase && (delta.was == nil || delta.is.status != delta.was.status)
		}
		tracker_was.all() {|was|
			delta = Delta.new
			delta.was = was
			delta.is = tracker_is.find(was.filename)

			yield delta if was.type.downcase == type.downcase && delta.is == nil
		}
	end
end
