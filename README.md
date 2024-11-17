Log Processor
=============

This Ruby project processes log data by parsing and tagging logs based on a lookup table and protocol map. It also includes an observer pattern to track various statistics based on the processed logs.

Project Overview
----------------

This program reads log data from a file, parses the logs based on a protocol map, tags the logs using a lookup table, and then processes the logs using various strategies to gather statistics. The application follows a modular design, making it easy to add new strategies and extend its functionality.

### Key Features:

-   **Log Parsing**: Parse log data using a predefined protocol map.
-   **Log Tagging**: Tag logs using a lookup table.
-   **Statistics Collection**: Track statistics such as tag counts and protocol/port counts using observer strategies.
-   **Modular Design**: Easily extendable with additional strategies for gathering statistics.
-   **File Input/Output**: Input files are loaded from a specified path and processed accordingly.

Requirements
------------

-   Ruby (version 2.x or higher)
-   No additional gems are required unless explicitly mentioned in the future.

Setup
-----

### Clone the repository

Clone this repository to your local machine using Git:

bash

Copy code

`git clone https://github.com/shashankdass/log-processor.git
cd log-processor`

### Install dependencies (if needed)

``` gem install nokogiri```

### File Structure

Your project should have the following structure:


```
log-processor/
├── README.md
├── main.rb                  # Main Ruby program
├── lookup.txt               # Lookup table file
├── logs.txt                 # Logs file to be processed
├── parser/
│   └── log_parser.rb        # LogParser class
├── tagger/
│   └── log_tagger.rb        # LogTagger class
├── stats/
│   ├── log_stats_observer.rb # Observer to collect stats
│   ├── tag_count_strategy.rb  # Tag counting strategy
│   ├── port_protocol_count_strategy.rb # Protocol/Port counting strategy
├── loaders/
│   ├── load_lookup_table.rb  # Lookup table loader
│   ├── load_logs.rb          # Logs loader
│   └── protocol_map.rb       # Protocol map loader`
```
### Configuration

Before running the program, ensure you have the following files:

-   **lookup.txt**: A text file containing the lookup table for log tagging.
-   **logs.txt**: A text file containing the logs that you want to process.

Modify the paths to these files in the `main.rb` program if necessary.

Running the Program
-------------------

### Command-Line Usage

You can run the program either for testing purposes or to execute the main program.

#### Running the Tests

The project includes a set of unit tests that validate various components, such as log parsing and tagging. To run the tests:

`ruby run.rb test`

This command will automatically run all the test files in the `test/` folder.

#### Running the Main Program

To run the actual program that processes logs:

`ruby run.rb main`

This will execute the `main.rb` program, which processes logs and calculates statistics.

### Example Input and Output

1.  **Input Files**:

    -   `lookup.txt`: Contains a list of tags and their associated values used for log tagging.
    -   `logs.txt`: Contains log data that the program will parse and tag according to the lookup table and protocol map.
2.  **Processing Flow**:

    -   The program loads the lookup table and the logs.
    -   It then parses the logs based on the protocol map.
    -   Logs are tagged with relevant data.
    -   The observer collects statistics based on the tagging.
3.  **Output**:

    -   After running, the output will be printed in the console (or it could be extended to output to a file if required).
    -   The statistics, such as tag counts and protocol/port counts, will be displayed.

Code Structure
--------------

### Main Program (`main.rb`)

The main entry point of the application. It orchestrates the loading of data, log parsing, tagging, and processing:

```
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
```
### Class Descriptions

-   **LogParser**: Responsible for parsing logs based on the protocol map.
-   **LogTagger**: Tags logs based on the lookup table.
-   **LogStatsObserver**: An observer that collects log statistics, such as tag counts and protocol/port counts.
-   **LogProcessor**: Processes the logs, applies the parser and tagger, and notifies the observer with statistics.

### Strategies

The observer pattern allows different strategies to be applied to collect various statistics from the logs:

-   **TagCountStrategy**: Counts occurrences of each tag in the logs.
-   **PortProtocolCountStrategy**: Counts the number of logs for each port/protocol combination.
