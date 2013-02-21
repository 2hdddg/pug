
class Difference
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

class Differences
	def get(type, tracker_is, tracker_was)
		diffs = []
		all = tracker_is.all type
		all.each{|is|
			diff = Difference.new
			diff.is = is
			diff.was = tracker_was.find(type, is.filename)

			diffs.push diff if diff.was == nil || diff.is.status != diff.was.status
		}
		diffs
	end
end
