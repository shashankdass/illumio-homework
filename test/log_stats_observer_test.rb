require 'minitest/autorun'
require_relative '../stats/log_stats_observer'
require_relative '../stats/tag_count_strategy'
require_relative '../stats/port_protocol_count_strategy'

class LogStatsObserverTest < Minitest::Test
  def setup
    @observer = LogStatsObserver.new
  end

  def test_add_strategy
    tag_count_strategy = TagCountStrategy.new
    @observer.add_strategy(tag_count_strategy)
    assert_includes @observer.instance_variable_get(:@strategies), tag_count_strategy
  end

  def test_update_statistics
    tag_count_strategy = TagCountStrategy.new
    @observer.add_strategy(tag_count_strategy)

    # Simulate a log update with tags and protocol details
    log_line = "2 123456789012 eni-0a1b2c3d 10.0.1.201 198.51.100.2 443 49153 6 25 20000 1620140761 1620140821 ACCEPT OK"
    applied_tags = ['sv_P1']
    details = { port: "49153", protocol: "TCP" }

    # Update statistics
    @observer.update(log_line, applied_tags, details)
    
    # Check if the statistics were updated correctly
    assert_equal 1, tag_count_strategy.instance_variable_get(:@tag_counter)['sv_P1']
  end

  def test_display_statistics
    tag_count_strategy = TagCountStrategy.new
    @observer.add_strategy(tag_count_strategy)

    log_line = "2 123456789012 eni-0a1b2c3d 10.0.1.201 198.51.100.2 443 49153 6 25 20000 1620140761 1620140821 ACCEPT OK"
    applied_tags = ['sv_P1']
    details = { port: "49153", protocol: "TCP" }
    
    @observer.update(log_line, applied_tags, details)

    # Capture the output and test if it prints the correct statistics
    assert_output(/sv_P1,1/) { @observer.display_statistics }
  end
end
