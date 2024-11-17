require_relative 'statistics_strategy_base_class'

class PortProtocolCountStrategy < StatisticsStrategy
  def initialize
    @port_protocol_counter = Hash.new(0)
  end

  def update(log_line, applied_tags, details)
    key = "#{details[:port]},#{details[:protocol]}"
    @port_protocol_counter[key] += 1
  end

  def display_statistics
    puts "\nPort/Protocol Counts:"
    @port_protocol_counter.each do |key, count|
      port, protocol = key.split(',')
      puts "#{port},#{protocol},#{count}"
    end
  end
end
