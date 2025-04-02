require 'optarse'


def random_character
  return rand(97..122)

def random_number
    return rand(1..9)
  
def main
  puts 'in main'


end

def parse_arguments
  options = {}

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: your_script.rb [options]"
    
    opts.on("-c COUNT Integer, "Specify a count (must be an integer between 1 and 5000)") do |value|
      unless value.between?(1, 5000)
        raise ArgumentError, "Value must be between 1, and 5000"
      end
      options[:count] = value
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
