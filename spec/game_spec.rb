require 'rspec'
require 'unicode'
require_relative '../lib/game'

describe 'Win Game' do
  it 'should do win finished' do
    game = Game.new('слово')
    expect(game.status).to eq :in_progress

    game.next_step('с')
    game.next_step('л')
    game.next_step('о')
    game.next_step('в')
    game.next_step('о')

    expect(game.status).to eq :win
    expect(game.number_of_errors).to eq 0
  end

  it 'should do lose finished' do
    game = Game.new('слово')
    expect(game.status).to eq :in_progress

    game.next_step('.')
    game.next_step('4')
    game.next_step('3')
    game.next_step('2')
    game.next_step('1')
    game.next_step('5')
    game.next_step('6')
    game.next_step('7')

    expect(game.status).to eq :lose
    expect(game.number_of_errors).to eq 7
  end
end