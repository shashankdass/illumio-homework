require_relative 'statistics_strategy_base_class'
class TagCountStrategy < StatisticsStrategy
    def initialize
      @tag_counter = Hash.new(0)
      @untagged_count = 0
    end
  
    def update(log_line, applied_tags, details)
      if applied_tags.empty?
        @untagged_count += 1
      else
        applied_tags.each { |tag| @tag_counter[tag] += 1 }
      end
    end
  
    def display_statistics
      puts "\nTag Counts:"
      @tag_counter.each { |tag, count| puts "#{tag},#{count}" }
      puts "Untagged,#{@untagged_count}"
    end
  end
  