root = File.expand_path(File.dirname(__FILE__))
Dir.glob(File.join(root, '*.rb')).select do |f|
	! f.match(/^pug.rb$/)
end.each do |f|
  require f 
end
