class Game
  MAX_ERRORS = 7
  attr_accessor :letters, :good_letters, :bad_letters, :status, :number_of_errors, :version

  def get_letters(slovo)
     abort "Отсутствует слово" if slovo == nil || slovo == ""
     slovo.split("")
  end

  def initialize(slovo)
    @letters = get_letters(Unicode::downcase(slovo))
    @number_of_errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress # :win, :lose
  end

  def next_step(letter)
    duplicate = { е: 'ё', ё: 'е', и: 'й', й: 'и' }
    letter_dup = duplicate[letter.to_sym] if duplicate.has_key?(letter.to_sym)

    return if letter_already_used?(letter, letter_dup) || win? || lose?

    if [letter, letter_dup].any? { |l| @letters.include?(l) }
      @good_letters << letter
      @good_letters << letter_dup unless letter_dup == nil
      @status = :win if win?
    else
      @bad_letters.push(letter)
      @number_of_errors += 1
      @status = :lose if @number_of_errors >= MAX_ERRORS
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву:"
    letter = ""
    letter = Unicode::downcase(STDIN.gets.chomp) while letter == ""
    next_step(letter)
  end

  def letter_already_used?(letter, letter_dup)
    [letter, letter_dup].any? { |l| @good_letters.include?(l) || @bad_letters.include?(l) }
  end

  def win?
    @status == :win || good_letters_without_dup.uniq.size == @letters.uniq.size
  end

  def lose?
    @status == :lose || @number_of_errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @number_of_errors
  end

  def good_letters_without_dup
    if ['е', 'ё', 'и', 'й'].any? { |item| good_letters.include?(item) }
      good_letters.reject { |letter| letter == "ё" || letter == "й" }
    else
      good_letters
    end
  end
end
