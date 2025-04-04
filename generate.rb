
# -*- Mode:Ruby; Coding:utf-8; fill-column:80 -*-

################################################################################
# @file      generate.rb
# @author    Greg Nelson
# @Copyright Copyright 2025 by Greg Nelson.  All rights reserved.
# @brief     Code generator using optparse in Ruby
# @Keywords  ruby code generator
# @Std       Ruby 3.0
#
# @example
#   ruby generate.rb -c 20 -l 9 -i 5
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
# ruby generate.rb -c <# of codes> -l <# of characters> -i <# of integers>
#
##------------------------------------------------------------------------------

require 'optparse'

MAX_ITERATION = 1000

# Class for initializing, creating, and parsing fixed length codes.
class Code
  def initialize(count, characters, integers)
    @count = count
    @characters = characters
    @integers = integers
    @temp = []
    @duplicate = 0
    @hash = {}
  end

  # Produces a random integer between a a min and max integer.
  #
  # == Parameters:
  # min_int:: Minimum Number (Integer)
  # max_int:: Maximum Number (Integer)
  #
  # == Returns:
  # Random Number
  def random_number(min_int, max_int)
    return rand(min_int..max_int)
  end

  # Parses the generated codes, electing random indexes to rearrange.
  #
  # == Parameters:
  # None
  #
  # == Returns:
  # String (code)
  def parse
    code = []

    while @temp.length > 0
      idx = self.random_number(0, (@temp.length) - 1)
      value = @temp.delete_at(idx).to_s
      code << value
    end

    return code.map(&:to_s).join

  end

  # Entry point to the class.  Gathers the correct amount of characters and integers.
  #
  # == Parameters:
  # None
  #
  # == Returns:
  # None
  def main
    idx = 0
    cnt = 0
    min_int = 1
    max_int = 9

    while cnt < @count
      break @code.clear if @duplicate == MAX_ITERATION
      while idx < @characters
        value = self.random_number(97, 122)
        @temp << value.chr
        idx += 1
      end

      idx = 0
      while idx < @integers
        value = self.random_number(min_int, max_int)
        @temp << value
        idx += 1
      end

      rearranged_code = self.parse

      key = rearranged_code[0, 2]

      if @hash.key?(key) && @hash[key].include?(rearranged_code)
        @duplicate += 1
        next
      end
      
      @hash[key] ||= []
      @hash[key] << rearranged_code

      # clearing the list for re-use
      @temp.clear

      cnt += 1
      idx = 0
    end

    # if the same codes continuously appear at the amount of the variable MAX_ITERATION
    if @duplicate == MAX_ITERATION
      puts "The number of unique codes is limited due to a fixed set of possible combinations"
    else
      # outputting the generated codes
      puts "Generated Codes\n\n"
      @hash.values.each do |value|
        puts value
      end
    end
  end

end

# Parses CLI arguments.
#
# == Parameters:
# None
#
# == Returns:
# Options (CLI Arguments)
def parse_arguments
  options = {}

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: main.rb [-c -i -l]"

    opts.on("-c COUNT", Integer, "Integer between 1 and 1000000") do |value|
      if value < 1 || value > 1000000
        raise ArgumentError, "Count must be between 1 and 1000000"
      end
      options[:count] = value
    end

    opts.on("-l CHARACTERS", Integer, "Integer between 1 and 20") do |value|
      if value < 1 || value > 20
        raise ArgumentError, "Character count must be between 1 and 20"
      end
      options[:letter] = value
    end

    opts.on("-i INTEGERS", Integer, "Integer between 1 and 20") do |value|
      if value < 1 || value > 20
        raise ArgumentError, "Integer count must be between 1 and 20"
      end
      options[:integer] = value
    end

    opts.on("-v", "--verbose", "Enable verbose mode") do
      options[:verbose] = true
    end

    opts.on("-h", "--help", "Help Information") do
      puts <<~HELP
        This script allows you to perform various operations with configurable
        options. You can specify a count/amount (integer between 1 and 1,000,000) with -c,
        character count (integer between 1 and 20) with -l, and an integer character (integer between 1
        and 20) with -i, and enable verbose mode with -v. Use -h or --help to
        display this message.
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
    puts "Error: -c (count), -l (characters), and -i (integers) are required."
    exit 1
  end

  options
end

if __FILE__ == $0
  options = parse_arguments
  get_codes = Code.new(options[:count], options[:letter], options[:integer])
  get_codes.main
end
