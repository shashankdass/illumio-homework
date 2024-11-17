# Strategy Pattern: Define a Tagging Strategy
class TaggingStrategy
    def apply_tags(log_line, details)
      raise NotImplementedError, 'Subclasses must implement this method'
    end
  end