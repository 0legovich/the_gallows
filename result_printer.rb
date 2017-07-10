class ResultPrinter
  def initialize
    @status_image = []

    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= 7
      file_name = current_path + "/image/#{counter}.txt"
      if File.exist?(file_name)
        f = File.new(file_name)
        @status_image << f.read
        f.close
      else
        @status_image << "\n[Изображение #{counter} не найдено!]\n"
      end
      counter += 1
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ""
    letters.each do |letter|
      if good_letters.include? letter
        result += "#{letter} "
      else
        result += "__ "
      end
    end
    result
  end

  def print_viselitsa(number_of_errors)
    puts @status_image[number_of_errors]
  end

  def print_status(game)
    system "clear"
    puts "\nСлово: " + get_word_for_print(game.letters, game.good_letters)

    if game.number_of_errors > 0
      puts "Ошибок: #{game.number_of_errors}, а именно буквы: #{game.bad_letters.join(", ")}"
    else
      puts "Ошибок нет."
    end

    print_viselitsa(game.number_of_errors)

    if game.number_of_errors >= 7
      abort "Вы проиграли"
    else
      if game.letters.uniq.size == game.good_letters.without_dup.uniq.size
        abort "Вы выиграли!"
      else
        puts "Попыток осталось #{7 - game.number_of_errors}"
      end
    end
  end
end
