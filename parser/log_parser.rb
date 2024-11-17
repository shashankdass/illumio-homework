class LogParser
    def initialize(protocol_map)
        @protocol_map = protocol_map
    end

    def parse(log_line)
        parts = log_line.split
        return {} if parts.length < 8
    
        port = parts[6]  # 7th entry is the port
        protocol_number = parts[7].to_i  # 8th entry is the protocol number
        protocol = @protocol_map[protocol_number] || 'unknown'
    
        { port: port, protocol: protocol }
    end
end