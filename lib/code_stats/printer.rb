require 'rainbow'

class CodeStats
  class Printer

    def initialize(report)
      @report = report
    end

    def print
      @report.each do |dir, depth_reports|
        puts "========== #{dir}"
        (1...depth_reports.size).each do |depth|
          puts "Depth #{depth}"
          puts ""
          depth_reports[depth].each do |dir, report|
            report(dir, report)
          end
        end
        puts ""
        puts 'Summary'.bright
        report('', depth_reports[0].values.first)
      end
    end
    
    def report(label, report)
      puts "%-60s %10s %10s" % [label, report.lines, "Lines".color(:red)]
      puts "%-60s %10s %10s" % ['', report.code, "Code".color(:blue)]
      puts "%-60s %10s %10s" % ['', report.comments, "Comments".color(:green)]
      puts "%-60s %10.2f %10s" % ['', report.comments.to_f / report.code, "Comments to code %"] unless report.code.zero?
      puts "%-60s %10s %10s" % ['', report.empty, "Empty".color(:magenta)]
    end

  end
end