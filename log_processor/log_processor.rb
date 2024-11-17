class LogProcessor
    def initialize(log_parser, log_tagger, observer)
        @log_parser = log_parser
        @log_tagger = log_tagger
        @observer = observer
    end
  
    def process_logs(logs)
        logs.each do |log|
            details = @log_parser.parse(log)
            next if details.empty?  # Skip log if it doesn't have enough entries
    
            applied_tags = @log_tagger.tag(log, details)
    
            # Notify the observer about the updates (statistics)
            @observer.update(log, applied_tags, details)
        end
    
        # Once all logs are processed, display the statistics
        @observer.display_statistics
    end
  end
  