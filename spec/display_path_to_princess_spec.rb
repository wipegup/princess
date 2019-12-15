require 'spec_helper'
require './lib/functions'
require './lib/grid'
require './lib/move_processor'


def test_display_path(file_path)
  $stdout = StringIO.new # Save output to StringIO

  grid = Grid.new(path: file_path)
  m_p = MoveProcessor.new(grid)
  displayPathtoPrincess(grid.n, grid.array)
  result = $stdout.string

  m_p.move_list(result)
  expect(m_p.best_score?).to eq(true)

  grid = Grid.new(path: file_path)
  expected = m_p.moves.join("\n")
  expect { displayPathtoPrincess(grid.n, grid.array) }.to output(expected).to_stdout
  expect(displayPathtoPrincess(grid.n, grid.array)).to eq(nil)

  $stdout = STDOUT # Reset output to standard output
end

describe "displayPathtoPrincess" do
  it "solves test_1" do
    test_display_path('./data/test_1.txt')
  end

  it "solves test_2" do
    test_display_path('./data/test_2.txt')
  end

  it "solves test_3" do
    test_display_path('./data/test_3.txt')
  end

  it "solves test_4" do
    test_display_path('./data/test_4.txt')
  end

end
