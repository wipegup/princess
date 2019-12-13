class MoveProcessor
  attr_reader :moves, :min_moves
  def initialize(grid)
    @grid = grid
    @moves = []
    @min_moves = calculate_minimum_moves
  end

  def move(direction)
    valid_move = @grid.move(direction)
    return false unless valid_move
    @moves << direction
    return true if @grid.solved?

    [@grid.n, @grid.r, @grid.c, @grid.array]
  end

  def move_list(direction_list)
    directions = direction_list.split("\n")

    directions.each do |direction|
      valid_move = move(direction)
      return false unless valid_move
    end

    @grid.solved?
  end

  def best_score?
    return nil unless @grid.solved?

    @min_moves == @moves.length
  end

  private
  def calculate_minimum_moves
    p_col = nil
    p_row = @grid.array.index{|row| p_col = row.index('p')}

    (p_row - @grid.r).abs + (p_col - @grid.c).abs
  end
end
