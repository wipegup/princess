require 'spec_helper'
require './lib/move_processor'
require './lib/grid'

describe MoveProcessor do
  describe "initialization" do
    before :all do
      @grid = Grid.new(path: './data/test_1.txt')
      @m_p = MoveProcessor.new(@grid)
    end

    it "exists" do
      expect(@m_p).to be_a(MoveProcessor)
    end

    it "calculates minimum number of moves" do
      expect(@m_p.min_moves).to eq(2)
    end

    it "initializes moves taken" do
      expect(@m_p.moves).to eq([])
    end
  end
  describe "instance methods" do
    describe "move" do
      before :each do
        @grid = Grid.new(path: './data/test_1.txt')
        @m_p = MoveProcessor.new(@grid)
      end
      describe "if valid" do
        describe "and does not solve the grid" do
          it "returns arguments for next call of nextMove" do
            expected = [3, 1, 0, ['---','m--','p--']]
            expect(@m_p.move("LEFT")).to eq(expected)
          end

          it "adds to move list" do
            @m_p.move("LEFT")
            expect(@m_p.moves).to eq(['LEFT'])
          end
        end

        describe "and does solve the grid" do
          it "returns true" do
            @m_p.move("LEFT")
            expect(@m_p.move("DOWN")).to eq(true)
          end
        end
      end
      describe "if invalid" do
        it "returns false" do
          @m_p.move("LEFT")
          expect(@m_p.move("LEFT")).to eq(false)
        end
      end
    end

    describe "move_list" do
      before :each do
        @grid = Grid.new(path: './data/test_1.txt')
        @m_p = MoveProcessor.new(@grid)
      end
      describe "moves solve grid" do
        it "returns true" do
          expect(@m_p.move_list("LEFT\nDOWN")).to eq(true)
          expect(@m_p.moves).to eq(['LEFT','DOWN'])
        end
      end
      describe "moves do not solve grid" do
        it "returns false when m and p do not converge" do
          expect(@m_p.move_list("LEFT\nUP")).to eq(false)
          expect(@m_p.moves).to eq(['LEFT','UP'])
        end

        it "returns false when illegal move occurs" do
          expect(@m_p.move_list("LEFT\nLEFT")).to eq(false)
          expect(@m_p.moves).to eq(['LEFT'])
        end
      end
    end

    describe "best_score?" do
      before :each do
        @grid = Grid.new(path: './data/test_1.txt')
        @m_p = MoveProcessor.new(@grid)
      end
      describe "if grid incomplete" do
        it "returns nil" do
          @m_p.move("LEFT")
          expect(@m_p.best_score?).to eq(nil)
        end
      end
      describe "if grid complete" do
        it "returns false if moves > min_moves" do
          @m_p.move("RIGHT")
          @m_p.move("LEFT")
          @m_p.move("LEFT")
          @m_p.move("DOWN")

          expect(@m_p.best_score?).to eq(false)
        end
        it "returns true if moves == min_moves" do
          @m_p.move("LEFT")
          @m_p.move("DOWN")
          expect(@m_p.best_score?).to eq(true)
        end
      end
    end
  end
end
