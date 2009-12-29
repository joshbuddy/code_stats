$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require 'code_stats/tasks'
require 'code_stats/printer'

class CodeStats
  
  class Stats
    
    attr_reader :file
    attr_accessor :lines, :comments, :empty
    
    def initialize(file)
      @file = file
      @lines, @comments, @empty = 0, 0, 0

      File.open(file).each_line do |line|
        @lines += 1
        case line
        when /^\s*$/
          @empty += 1
        when /^\s*#/
          @comments += 1
        end
      end

    end
    
    def code
      lines - comments - empty
    end

  end
  
  class Report
    
    attr_accessor :lines, :comments, :empty
    
    def initialize(*directories)
      @directories = directories
      @lines, @comments, @empty = 0, 0, 0
    end
    
    def <<(stats)
      @lines += stats.lines
      @comments += stats.comments
      @empty += stats.empty
    end
    
    def code
      lines - comments - empty
    end

  end
  
  attr_reader :directories, :reporting_depth, :file_extensions
  
  def initialize(options)
    @directories = options[:directories] ? Array(options[:directories]) : raise('need to specify directory')
    @reporting_depth = options[:reporting_depth] || 0
    @file_extensions = Array(options[:file_extensions] || 'rb')
  end
  
  def run
    reports = Hash.new{|h,k| h[k] = []}
    directories.each do |dir|
      Dir.glob(File.join(dir, '**', "*.{#{file_extensions * ','}}")) do |entry|
        relative_entry = entry[entry.index(dir) + dir.size, entry.size]
        relative_entry_parts = File.dirname(relative_entry).split(File::SEPARATOR).select{|f| not f.nil? || f.empty?}
        stats = Stats.new(entry)
        (0..reporting_depth).each do |depth|
          if relative_entry_parts.size >= depth
            reports[dir][depth] ||= {}
            reports[dir][depth][relative_entry_parts[0, depth]] ||= Report.new(relative_entry_parts[0, depth])
            reports[dir][depth][relative_entry_parts[0, depth]] << stats
          end
        end
      end
    end
    reports
  end
  
end