require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'code_stats'))

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "code_stats"
    s.description = s.summary = "Brief code stats from your rakefile"
    s.email = "joshbuddy@gmail.com"
    s.homepage = "http://github.com/joshbuddy/code_stats"
    s.authors = ["Joshua Hull"]
    s.files = FileList["[A-Z]*", "{lib}/**/*"]
    s.add_dependency 'rainbow'
    s.add_dependency 'dirge', '>=0.0.3'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

CodeStats::Tasks.new :reporting_depth => 2


