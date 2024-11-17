require 'json'
require_relative 'parser/log_parser'
require_relative 'tagger/log_tagger'
require_relative 'stats/log_stats_observer'
require_relative 'stats/tag_count_strategy'
require_relative 'stats/port_protocol_count_strategy'
require_relative 'log_processor/log_processor'
require_relative 'loaders/load_lookup_table'
require_relative 'loaders/load_logs'
require_relative 'loaders/protocol_map'

def main
  lookup_file_path = 'lookup.txt'  # Path to the lookup table (text file)
  log_file_path = 'logs.txt'  # Path to the log file
  
  # Load lookup table, logs from files and protocol map
  lookup_table = LoadLookUpTable.new(lookup_file_path).load_from_file
  logs = LoadLogs.new(log_file_path).load_from_file
  protocol_map = ProtocolMap.new.get_protocol_map
  
  # Create log parser and tagger
  log_parser = LogParser.new(protocol_map)
  log_tagger = LogTagger.new(lookup_table)

  # Create strategy and observer
  observer = LogStatsObserver.new
  observer.add_strategy(TagCountStrategy.new)
  observer.add_strategy(PortProtocolCountStrategy.new)

  # Create log processor
  log_processor = LogProcessor.new(log_parser, log_tagger, observer)
  
  # Process logs and get tagged logs
  log_processor.process_logs(logs)
end

# Run the main function
main
