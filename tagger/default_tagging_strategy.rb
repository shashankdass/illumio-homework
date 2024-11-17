# Concrete Strategy for Default Tagging (uses lookup table)
class DefaultTaggingStrategy < TaggingStrategy
    def initialize(lookup_table, protocol_map)
        @lookup_table = lookup_table
        @protocol_map = protocol_map
    end

    # Map protocol number to protocol name
    def get_protocol_name(protocol_number)
        @protocol_map[protocol_number] || 'unknown'
    end

    # Apply tags based on the lookup table (port/protocol mapping)
    def apply_tags(log_line, details)
        port = details[:port]
        protocol = details[:protocol]
        
        applied_tags = []
        @lookup_table.each do |entry|
        if entry[:prt] == port && entry[:protocol] == protocol
            applied_tags << entry[:tag]
        end
        end

        applied_tags
    end
end