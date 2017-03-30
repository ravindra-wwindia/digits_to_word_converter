require_relative 'lib/digits_to_word_converter.rb'

puts "Enter 10 digit number"
digits = gets.chomp

if digits.length > 0
  input_digits = digits
else
  input_digits = "6686787825"
end

p Benchmark.measure {
  begin
    digit_converter = DigitsToWordConverter.new
    puts digit_converter.parse(input_digits)
  rescue ArgumentError
    puts "Mobile number should be only 10 digit as well as should not contain 0 and 1"
  end
}