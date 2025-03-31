require 'optarse'

def main
  puts 'in main'


end

def parse_arguments
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Usage: your_script.rb [options]"
    
    opts.on("-cCOUNT", "--count=COUNT", Integer, "Specify a count (must be an integer between 1 and 5000)") do |count|
      if count < 1 || count > 5000
        puts "Error: Count must be between 1 and 5000!"
        exit 1
      end
      options[:count] = count
    end

    opts.on("-v", "--verbose", "Enable verbose mode") do
      options[:verbose] = true
    end

    opts.on("-h", "--help", "Prints this help") do
      puts <<~HELP
        This script allows you to perform various operations with configurable options.
        You can specify a config file using the -c or --count option, and enable verbose
        mode with the -v or --verbose option. Use -h or --help to display this message.
        The user is required to add a count (integer) ranging from 1 - 5000.
      HELP
      exit
    end
  end.parse!

  options
end
if __FILE__ == $0
  options = parse_arguments
  main(options)
