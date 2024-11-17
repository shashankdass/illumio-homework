# run.rb

# Get the argument passed to the script
command = ARGV[0]

# Check what command was passed
case command
when "test"
  # Run all tests in the 'test' folder
  puts "Running tests..."
  system("ruby -I. -e \"Dir['test/*_test.rb'].each { |file| require file }\"")

  # Check if tests passed
  if $?.success?
    puts "Tests passed!"
  else
    puts "Tests failed. Exiting."
  end

when "main"
  # Run the main program
  puts "Running the main program..."
  system("ruby main.rb")

  # Check if the main program ran successfully
  if $?.success?
    puts "Main program ran successfully!"
  else
    puts "Main program encountered an error."
  end

else
  # If no valid argument is provided
  puts "Please provide a valid argument: 'test' to run tests, or 'main' to run the main program."
  exit 1
end
