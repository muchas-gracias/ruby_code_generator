require 'optarse'

def main
  puts 'in main'


end

def parse_arguments
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Usage: your_script.rb [options]"

    opts.on("-cFILE", "--config=FILE", "Specify a config file") do |file|
      options[:config] = file
    end

    opts.on("-v", "--verbose", "Enable verbose mode") do
      options[:verbose] = true
    end

    opts.on("-h", "--help", "Prints this help") do
      puts opts
      exit
    end
  end.parse!

  options
end
if __FILE__ == $0
  options = parse_arguments
  main(options)
