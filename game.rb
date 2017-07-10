class Game
  attr_accessor :letters, :good_letters, :bad_letters, :status, :number_of_errors

  def get_letters(slovo)
     abort "Отсутствует слово" if slovo == nil || slovo == ""
     slovo.split("")
  end

  def initialize(slovo)
    @letters = get_letters(Unicode::downcase(slovo))
    @number_of_errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def next_step(letter)
    duplicate = { 'е': 'ё', 'ё': 'е', 'и': 'й', 'й': 'и' }
    letter_dup = duplicate.fetch(letter.to_sym) if duplicate.has_key?(letter.to_sym)

    return if letter_already_used?(letter, letter_dup) || win? || lose?

    if [letter, letter_dup].any? { |l| @letters.include?(l) }
      @good_letters.push(letter)
      @good_letters.push(letter_dup) unless letter_dup == nil
      @status = 1 if @good_letters.without_dup.uniq.size == @letters.uniq.size
    else
      @bad_letters.push(letter)
      @number_of_errors += 1
      @status = -1 if @number_of_errors >= 7
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву:"

    letter = ""
    while letter == ""
      letter = Unicode::downcase(STDIN.gets.chomp)
    end
    letter
    next_step(letter)
  end

  def letter_already_used?(letter, letter_dup)
    [letter, letter_dup].any? { |l| @good_letters.include?(l) || @bad_letters.include?(l) }
  end

  def win?
    @status == 1
  end

  def lose?
    @status == -1
  end

  private
  def without_dup
    self.delete("ё") if ["е", "ё"].any? { |letter| self.include?(letter) }
    self.delete("й") if ["и", "й"].any? { |letter| self.include?(letter) }
    self
  end
end
