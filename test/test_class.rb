require 'minitest/autorun'
require_relative '../generate'

class TestClass < Minitest::Test
    def test_random_number
        code = Code.new(1, 1, 1)
        min = 97
        max = 120
        100.times do
            return_value = code.random_number(min, max)
            assert_includes (min..max), return_value
        end
    end
end