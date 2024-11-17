require_relative 'loader_base_class'

class LoadLogs < Loader
    def load_from_file
        File.readlines(@file).map(&:strip)
    end
end