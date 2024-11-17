class Loader
    def initialize(file)
        @file = file 
    end
    def load_from_file 
        raise NotImplementedError, 'Subclasses must implement this method'
    end
end
    