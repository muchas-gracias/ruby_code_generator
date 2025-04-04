
# -*- Mode:Ruby; Coding:utf-8; fill-column:80 -*-

################################################################################
# @file      generate.rb
# @author    Greg nelson
# @Copyright Copyright 2025 by Greg Nelson.  All rights reserved.
# @brief     Code generator using optparse in Ruby
# @Keywords  ruby code generator
# @Std       Ruby 3.0
#
# @example
#   ruby generate.rb -c 20 -l 10 -i 5
#
# This script utilizes the optparse module in Ruby for command-line argument
# parsing.  The script generates a specific amount of fixed length codes,
# with a fixed amount of integers and characters.
#
# == Command Line Arguments:
#   -c COUNT    # of codes to produce
#   -l LETTER   number of letters in the code
#   -i INTEGER  number of integers in the code
#
#
# == Usage:
# To run this script, use the following command:
#   ruby argParse.rb --name <your_name> --age <your_age>
#
##------------------------------------------------------------------------------


require 'optparse'

class Code
  def initialize(count, letters, integers)
    @count = count
    @letters = letters
    @integers = integers
    @temp = []
    @code = []
  end

  def random_character
    return rand(97..122)
  end

  def random_number(min_int, max_int)
    return rand(min_int..max_int)
  end

  def parse
    cnt = 0
    code = []

    while cnt != @temp.length
      idx = self.random_number(0, (@temp.length) - 1)
      puts idx
      value = @temp.delete_at(idx)
      # code << value

      cnt += 1
    end
    # puts code


  end

  def main
    idx = 0
    cnt = 0
    min_int = 1
    max_int = 9

    while cnt < @count
      while idx < @letters
        value = self.random_character
        @temp << value.chr
        idx += 1
      end

      idx = 0
      while idx < @integers
        value = self.random_number(min_int, max_int)
        @temp << value
        idx += 1
      end

      self.parse
      # print @temp
      @temp.clear

      cnt += 1
      idx = 0
    end


  end

end

def parse_arguments
  options = {}

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: main.rb [-c -i -l]"

    opts.on("-c COUNT", Integer, "Specify a count (integer between 1 and 5000)") do |value|
      if value < 1 || value > 5000
        raise ArgumentError, "Count must be between 1 and 5000"
      end
      options[:count] = value
    end

    opts.on("-l LETTER", Integer, "Specify a letter amount (integer between 1 and 9)") do |value|
      if value < 1 || value > 9
        raise ArgumentError, "Letter count must be between 1 and 9"
      end
      options[:letter] = value
    end

    opts.on("-i Integer", Integer, "Specify an integer amount (integer between 1 and 9)") do |value|
      if value < 1 || value > 9
        raise ArgumentError, "Integer count must be between 1 and 9"
      end
      options[:integer] = value
    end

    opts.on("-v", "--verbose", "Enable verbose mode") do
      options[:verbose] = true
    end

    opts.on("-h", "--help", "Prints this help") do
      puts <<~HELP
        This script allows you to perform various operations with configurable options.
        You can specify a count (integer between 1 and 5000) with -c, level (integer between 1 and 9) with -l,
        intensity (integer between 1 and 9) with -i, and enable verbose mode with -v. Use -h or --help to display this message.
      HELP
      exit
    end
  end

  begin
    parser.parse!
  rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
    puts e.message
    puts parser.help
    exit 1
  rescue ArgumentError => e
    puts "Error: #{e.message}"
    exit 1
  end

  if options[:count].nil? || options[:letter].nil? || options[:integer].nil?
    puts "Error: -c (count), -l (letter), and -i (integer) are required."
    exit 1
  end

  options
end

if __FILE__ == $0
  options = parse_arguments
  get_codes = Code.new(options[:count], options[:letter], options[:integer])
  get_codes.main
end
