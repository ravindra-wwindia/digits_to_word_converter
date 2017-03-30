require 'set'
require 'benchmark'

# From given a 10 digit number, it will return all possible words or combination of words from the dictionary file
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

  # validate given number and process it
  def parse(number)
    if /\A[2-9]{10}\z/ =~ number
      possible_permutations = number_permutations(number)
      process_combinations(possible_permutations)
    else
      puts 'Mobile number should be only 10 digit as well as should not contain 0 and 1'
    end
  end

  # Find all possible combinations of number by spliting it
  # into possible two and three slices of number
  # Return type array
  def number_permutations(number)
    permutations = []

    [3, 4, 5, 6, 7, 10].each do |pattern|
      permutations << split_in_two(number, pattern)
    end
    [[3, 3], [3, 4], [4, 3]].each do |pattern|
      permutations << split_in_three(number, pattern.first, pattern.last)
    end

    permutations
  end

  # possible two slices [5, 5], [3, 7], [7, 3], [4, 6], [6, 4], [10, 0]
  def split_in_two(number, length)
    [number.slice(0, length), number.slice(length, 10 - length)]
  end

  # possible three slices [3, 3, 4], [4, 3, 3], [3, 4, 3]
  def split_in_three(number, length1, length2)
    [number.slice(0, length1), number.slice(length1, length2), number.slice(length1 + length2, 10)]
  end

  # Fetch all dictionary words from dictionary.txt and load in Set
  def dictionary
    @dictionary ||= Set.new(File.read('../dictionary.txt').downcase.split("\n"))
  end

  # Return final mapped words which are mached in dictionary.txt
  def process_combinations(combinations)
    output = []
    combinations.each do |combination|
      arr = []
      words = get_all_matched_words(combination, dictionary)
      arr.push(words) unless words.include?([])
      output.concat(arr)
    end
    mapped_words = []
    output.each { |f| mapped_words.concat(f[0].product(*f[1..-1])) }
    mapped_words.to_s
  end

  # Return all combination of words
  def get_all_matched_words(combination, dictionary)
    all_matched_words = []
    combination.map { |pattern| all_matched_words.push(find_matches(pattern, dictionary)) unless pattern.empty? }
    all_matched_words
  end

  # Process number combinations and find its possible words
  def find_matches(number, dictionary)
    words = []
    x = []
    number.split('').each { |digit| x.push(NUMBER_TO_WORD_MAPPER[digit]) }
    x[0].product(*x[1..-1]).each { |val| words.push(val.join) if dictionary.include? val.join } unless x.empty?
    words
  end
end
