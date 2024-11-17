class LogTagger
    def initialize(lookup_table)
      @lookup_table = lookup_table
    end
  
    def tag(log_line, details)
      port = details[:port]
      protocol = details[:protocol]
  
      applied_tags = []
      @lookup_table.each do |entry|
        if entry[:prt] == port && entry[:protocol].upcase == protocol.upcase
          applied_tags << entry[:tag]
        end
      end
      applied_tags
    end
  end
  