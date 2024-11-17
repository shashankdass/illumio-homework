require 'minitest/autorun'
require_relative '../log_processor/log_processor'
require_relative '../parser/log_parser'
require_relative '../tagger/log_tagger'
require_relative '../stats/log_stats_observer'
require_relative '../stats/tag_count_strategy'
require_relative '../stats/port_protocol_count_strategy'

class LogProcessorTest < Minitest::Test
  def setup
    protocol_map = { 1 => 'ICMP', 6 => 'TCP', 17 => 'UDP', 58 => 'ICMPv6' }
    lookup_table = [
      { prt: '49153', protocol: 'tcp', tag: 'sv_P1' },
      { prt: '49154', protocol: 'tcp', tag: 'sv_P2' }
    ]
    
    log_parser = LogParser.new(protocol_map)
    log_tagger = LogTagger.new(lookup_table)
    observer = LogStatsObserver.new
    observer.add_strategy(TagCountStrategy.new)
    observer.add_strategy(PortProtocolCountStrategy.new)

    @log_processor = LogProcessor.new(log_parser, log_tagger, observer)
  end

  def test_process_logs
    logs = [
      "2 123456789012 eni-0a1b2c3d 10.0.1.201 198.51.100.2 443 49153 6 25 20000 1620140761 1620140821 ACCEPT OK",
      "2 123456789012 eni-0a1b2c3d 10.0.1.201 198.51.100.2 80 49154 6 25 20000 1620140761 1620140821 ACCEPT OK",
      "2 123456789012 eni-0a1b2c3d 10.0.1.201 198.51.100.2 80 49155 6 25 20000 1620140761 1620140821 ACCEPT OK"
    ]

    # Process the logs
    @log_processor.process_logs(logs)

    # Check the statistics after processing logs
    assert_output(/sv_P1,1/) { @log_processor.instance_variable_get(:@observer).display_statistics }
    assert_output(/sv_P2,1/) { @log_processor.instance_variable_get(:@observer).display_statistics }
    assert_output(/Untagged,1/) { @log_processor.instance_variable_get(:@observer).display_statistics }

  end
end
