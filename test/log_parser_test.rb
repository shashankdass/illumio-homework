require 'minitest/autorun'
require_relative '../parser/log_parser'

class LogParserTest < Minitest::Test
  def setup
    # Example protocol map (can be replaced with actual map scraped from IANA)
    @protocol_map = {
      1 => 'ICMP',
      6 => 'TCP',
      17 => 'UDP',
      58 => 'ICMPv6'
    }
    @log_parser = LogParser.new(@protocol_map)
  end

  def test_parse_valid_log
    log_line = "2 123456789012 eni-0a1b2c3d 10.0.1.201 198.51.100.2 443 49153 6 25 20000 1620140761 1620140821 ACCEPT OK"
    expected = { port: "49153", protocol: "TCP" }
    p "I am here"
    assert_equal expected, @log_parser.parse(log_line)
  end

  def test_parse_log_with_unknown_protocol
    log_line = "2 123456789012 eni-0a1b2c3d 10.0.1.201 198.51.100.2 443 49153 99 25 20000 1620140761 1620140821 ACCEPT OK"
    expected = { port: "49153", protocol: "unknown" }
    assert_equal expected, @log_parser.parse(log_line)
  end

  def test_parse_log_with_missing_fields
    log_line = "2 123456789012 eni-0a1b2c3d"
    assert_empty @log_parser.parse(log_line)
  end
end
