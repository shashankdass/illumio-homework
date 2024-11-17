require_relative 'loader_base_class'
class LoadLookUpTable < Loader
    def load_from_file
        lookup_table = []
        File.readlines(@file).each do |line|
        parts = line.strip.split(',')  # Split on comma
            if parts.length == 3
                port, protocol, tag = parts
                lookup_table << { prt: port, protocol: protocol, tag: tag }
            end
        end
        lookup_table
        
    end
end