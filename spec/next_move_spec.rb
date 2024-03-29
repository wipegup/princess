require 'spec_helper'
require './lib/functions'
require './lib/grid'
require './lib/move_processor'

def test_next_move(file_path, stand_alone)
  $stdout = StringIO.new # Save output to StringIO

  grid = Grid.new(path: file_path)
  m_p = MoveProcessor.new(grid)

  expect { nextMove(grid.n, grid.r, grid.c, grid.array, stand_alone) }.to output.to_stdout
  expect( nextMove(grid.n, grid.r, grid.c, grid.array, stand_alone) ).to eq(nil)

  move = $stdout.string
  move_result = m_p.move(move)

  while move_result.instance_of? Array
    $stdout.string = ''

    nextMove(*move_result, stand_alone)
    move = $stdout.string
    move_result = m_p.move(move)
  end
  expect(m_p.best_score?).to eq(true) # Check for completed AND best score

  $stdout = STDOUT # Reset output to standard output
end

describe "nextMove" do
  it "solves test_1" do
    test_next_move('./data/test_1.txt', stand_alone = true)
    test_next_move('./data/test_1.txt', stand_alone = false)
  end

  it "solves test_2" do
    test_next_move('./data/test_2.txt', stand_alone = true)
    test_next_move('./data/test_2.txt', stand_alone = false)
  end

  it "solves test_3" do
    test_next_move('./data/test_3.txt', stand_alone = true)
    test_next_move('./data/test_3.txt', stand_alone = false)
  end

  it "solves test_4" do
    test_next_move('./data/test_4.txt', stand_alone = true)
    test_next_move('./data/test_4.txt', stand_alone = false)
  end

  it "solves test_5" do
    test_next_move('./data/test_5.txt', stand_alone = true)
    test_next_move('./data/test_5.txt', stand_alone = false)
  end

  it "solves test_6" do
    test_next_move('./data/test_6.txt', stand_alone = true)
    test_next_move('./data/test_6.txt', stand_alone = false)
  end
end
