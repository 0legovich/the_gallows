#Исполняемый файл приложения "Виселица"
require 'unicode'
require_relative 'array'

current_path = './' + File.dirname(__FILE__)

require current_path + '/game'
require current_path + '/result_printer'
require current_path + '/word_reader.rb'

printer = ResultPrinter.new
reader = WordReader.new
slovo = reader.read_from_file(current_path + '/data/words.txt')
game = Game.new(slovo)

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
