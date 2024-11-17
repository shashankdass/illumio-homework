require 'minitest/autorun'
require_relative '../tagger/log_tagger'

class LogTaggerTest < Minitest::Test
  def setup
    # Sample lookup table
    @lookup_table = [
      { prt: '443', protocol: 'tcp', tag: 'sv_P1' },
      { prt: '80', protocol: 'tcp', tag: 'sv_P2' },
      { prt: '443', protocol: 'udp', tag: 'sv_P3' }
    ]
    @log_tagger = LogTagger.new(@lookup_table)
  end

  def test_tag_valid_log
    details = { port: "443", protocol: "tcp" }
    expected_tags = ['sv_P1']
    assert_equal expected_tags, @log_tagger.tag("log_line", details)
  end

  def test_tag_log_with_multiple_tags
    details = { port: "443", protocol: "udp" }
    expected_tags = ['sv_P3']
    assert_equal expected_tags, @log_tagger.tag("log_line", details)
  end

  def test_tag_log_with_no_matching_tags
    details = { port: "8080", protocol: "tcp" }
    expected_tags = []
    assert_equal expected_tags, @log_tagger.tag("log_line", details)
  end
end
