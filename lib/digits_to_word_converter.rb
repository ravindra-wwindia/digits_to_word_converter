require 'pry'

class DigitsToWordConverter

  NUMBER_TO_WORD_MAPPER = {
    '2' => %w(a b c),
    '3' => %w(d e f),
    '4' => %w(g h i),
    '5' => %w(j k l),
    '6' => %w(m n o),
    '7' => %w(p q r s),
    '8' => %w(t u v),
    '9' => %w(w x y z)
  }.freeze

  def parse(number)
    if /\A[2-9]{10}\z/ =~ number
      possible_permutations = number_permutations(number)
    else
      puts 'Mobile number should be only 10 digit as well as should not contain 0 and 1'
    end
  end

  def number_permutations(number)
    permutations = []

    [3, 4, 5, 6, 7, 10].each do |pattern|
      permutations << split_in_two(number, pattern)
    end
    [[3,3],[3,4],[4,3]].each do |pattern|
      permutations << split_in_three(number, pattern.first, pattern.last)
    end

    permutations
  end

  def split_in_two(number, length)
    [number.slice(0, length), number.slice(length, 10 - length)]
  end

  def split_in_three(number, length1, length2)
    [number.slice(0, length1), number.slice(length1, length2), number.slice(length1 + length2, 10)]
  end
end

DigitsToWordConverter.new.parse('6686787825')
