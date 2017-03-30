require 'pry'
require 'set'

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
      process_combinations(possible_permutations)
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

  def dictionary
    Set.new(File.read('../dictionary.txt').downcase.split("\n"))
  end

  def process_combinations(combinations)
    combinations.each do |combination|
      words = get_all_matched_words(combination, dictionary)
      p words
    end
  end

  def get_all_matched_words(combination, dictionary)
    all_matched_words = []
    combination.map {|pattern| all_matched_words.push(find_matches(pattern, dictionary)) unless pattern.empty? }
    all_matched_words
  end

  def find_matches(number, dictionary)
    words = []
    x = []
    number.split('').each { |var| x.push(NUMBER_TO_WORD_MAPPER[var]) }
    x[0].product(*x[1..-1]).each { |val| words.push(val.join) if dictionary.include? val.join } unless x.empty?
    words
  end
end

DigitsToWordConverter.new.parse('6686787825')
