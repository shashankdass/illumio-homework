class StatisticsStrategy
    def update(log_line, applied_tags, details)
      raise NotImplementedError, 'Subclasses must implement this method'
    end
  
    def display_statistics
      raise NotImplementedError, 'Subclasses must implement this method'
    end
  end