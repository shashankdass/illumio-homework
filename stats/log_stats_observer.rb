# Observer Pattern: Observer for collecting statistics
class LogStatsObserver
    def initialize
      @tag_counter = Hash.new(0)
      @port_protocol_counter = Hash.new(0)
      @untagged_count = 0
      @strategies = []
    end
  
    def add_strategy(strategy)
      @strategies << strategy
    end
  
    def update(log_line, applied_tags, details)
        @strategies.each {|strategy| strategy.update(log_line, applied_tags, details)}
    end
  
    def display_statistics
      @strategies.each {|strategy| strategy.display_statistics}
    end
  end