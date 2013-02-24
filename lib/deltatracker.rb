
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
		"#{is.title}\n" +
		" #{diff}"
	end
end

class DeltaTracker
	def get(type, tracker_is, tracker_was)
		deltas = []
		all = tracker_is.all type
		all.each{|is|
			delta = Delta.new
			delta.is = is
			delta.was = tracker_was.find(type, is.filename)

			deltas.push delta if delta.was == nil || delta.is.status != delta.was.status
		}
		deltas
	end
end
