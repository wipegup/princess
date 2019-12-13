require 'spec_helper'
require './lib/grid'

SIMPLE_GRID = ['---','-m-','p--']
INVALID_GRID_ERROR = [ArgumentError, "Invalid Grid"]

describe "Grid class" do

  describe "instance method" do
    describe "r" do
      it "return row of m" do
        grid = Grid.new(array: SIMPLE_GRID)
        expect(grid.r).to eq(1)
      end
    end
    describe "c" do
      it "returns column of m" do
        grid = Grid.new(array: SIMPLE_GRID)
        expect(grid.c).to eq(1)
      end
    end
    describe "move" do
      it "returns false for invalid moves" do
        m_top_left = ['m--','---','p--']
        m_bottom_right = ['p--','---','--m']
        grid_top_left = Grid.new(array: m_top_left)
        grid_bottom_right = Grid.new(array: m_bottom_right)


        expect(grid_bottom_right.move("RIGHT")).to eq(false)
        expect(grid_bottom_right.move("DOWN")).to eq(false)
        expect(grid_top_left.move("LEFT")).to eq(false)
        expect(grid_top_left.move("UP")).to eq(false)
      end

      describe "for valid move" do
        describe "that does NOT solve the grid" do
          it "returns true" do

            m_bottom_right = ['p--','---','--m']
            grid = Grid.new(array: m_bottom_right)

            move_left = ['p--','---','-m-']
            expect(grid.move("LEFT")).to eq(true)

            move_up = ['p--','-m-','---']
            expect(grid.move("UP")).to eq(true)

            m_top_left = ['m--','---','p--']
            grid = Grid.new(array: m_top_left)

            move_down = ['---','m--','p--']
            expect(grid.move("DOWN")).to eq(true)

            move_right = ['---','-m-','p--']
            expect(grid.move("RIGHT")).to eq(true)
          end

          it "updates the array" do
            m_bottom_right = ['p--','---','--m']
            grid = Grid.new(array: m_bottom_right)

            move_left = ['p--','---','-m-']
            grid.move('LEFT')
            expect(grid.array).to eq(move_left)

            move_up = ['p--','-m-','---']
            grid.move('UP')
            expect(grid.array).to eq(move_up)

            m_top_left = ['m--','---','p--']
            grid = Grid.new(array: m_top_left)

            move_down = ['---','m--','p--']
            grid.move('DOWN')
            expect(grid.array).to eq(move_down)

            move_right = ['---','-m-','p--']
            grid.move('RIGHT')
            expect(grid.array).to eq(move_right)
          end
        end

        describe "that DOES solve the grid" do
          before :each do
            to_solve = ['pm-', '---', '---']
            @grid = Grid.new(array: to_solve)
          end

          it "returns true" do
            expect(@grid.move("LEFT")).to eq(true)
          end
          it "updates solved flag" do
            @grid.move("LEFT")
            expect(@grid.solved?).to eq(true)

          end
          it "updates grid -- with an x" do
            @grid.move("LEFT")

            solved = ['x--', '---', '---']
            expect(@grid.array).to eq(solved)
          end
        end
      end
    end

  end

  describe "initialization" do
    it "exists" do
      grid_path = Grid.new(path: './data/test_1.txt')
      grid_array = Grid.new(array: SIMPLE_GRID)

      expect(grid_path).to be_a(Grid)
      expect(grid_array).to be_a(Grid)
    end

    it "only accepts a single initialization argument" do
      invalid_initialization = Proc.new {Grid.new(path: '', grid_string: '')}
      expect( invalid_initialization ).to raise_error(ArgumentError, "Too many arguments")
    end

    it "sets solved to false" do
      grid = Grid.new(path: './data/test_1.txt')
      expect(grid.solved?).to eq(false)
    end

    it "parses from file with path_to_grid from TextToGrid module" do
      grid = Grid.new(path: './data/test_1.txt')

      expected = SIMPLE_GRID
      expect(grid.array).to eq(expected)
    end

    it "accepts array for grid" do
      grid = Grid.new(array: SIMPLE_GRID)

      expected = SIMPLE_GRID
      expect(grid.array).to eq(expected)
    end

    describe 'check_grid' do
      it "checks for presence of one and only one m" do
        no_m = ['---','---','p--']
        two_m = ['-mm','---','p--']
        expect {Grid.new(array: no_m)}.to raise_error(*INVALID_GRID_ERROR)
        expect {Grid.new(array: two_m)}.to raise_error(*INVALID_GRID_ERROR)
      end

      it "checks for presence of one and only one p" do
        no_p = ['---','-m-','---']
        two_p = ['---','-mp','p--']
        expect {Grid.new(array: no_p)}.to raise_error(*INVALID_GRID_ERROR)
        expect {Grid.new(array: two_p)}.to raise_error(*INVALID_GRID_ERROR)
      end

      it "checks for nxn matrix" do
        non_square_1 = ['---','-m-','---','p--']
        non_square_2 = ['----','-m--','---p']

        expect {Grid.new(array: non_square_1)}.to raise_error(*INVALID_GRID_ERROR)
        expect {Grid.new(array: non_square_2)}.to raise_error(*INVALID_GRID_ERROR)
      end

      it "correctly calculates n" do
        grid = Grid.new(array: SIMPLE_GRID)
        expect(grid.n).to eq(3)
      end
    end
  end
end
