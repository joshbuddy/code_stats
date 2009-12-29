require 'dirge'
require 'rake'
require 'rake/tasklib'

class CodeStats
  class Tasks < ::Rake::TaskLib
    
    attr_accessor :building_block, :options
    
    def initialize(options = {})
      self.options = options
      root_dir = __DIR_REL__(caller.find{|c| c=~/Rakefile/})

      options[:directories] ||= 'lib'
      options[:directories] = Array(options[:directories])
      options[:directories].map! do |dir|
        File.expand_path(File.join(root_dir, dir))
      end
      self.building_block = building_block
      define
    end

    def stats
      @stats ||= CodeStats.new(options)
    end

    def define
      desc "Code stats - lines of code"
      task :code_stats do
        Printer.new(stats.run).print
      end
    end

    attr_reader :building_block

  end
end