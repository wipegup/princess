def displayPathtoPrincess(n, grid, m_row = nil, m_col = nil, to_stdout = true)
  p_row, p_col = find_char_coordinates("p", grid)
  m_row, m_col = find_char_coordinates("m", grid) unless m_col && m_row

  row_diff = m_row - p_row
  col_diff = m_col - p_col

  go_down = row_diff < 0
  go_right = col_diff < 0

  directions = ''
  directions += go_down ? "DOWN\n" * row_diff.abs : "UP\n" * row_diff
  directions += go_right ? "RIGHT\n" * col_diff.abs : "LEFT\n" * col_diff

  to_stdout ? print(directions.chomp) : directions.chomp
end


def nextMove(n, r, c, grid, stand_alone = false)
  args = [n, r, c, grid]
  stand_alone ? stand_alone_next_move(*args) : dependent_next_move(*args)
end

def dependent_next_move(n, r, c, grid)
  direction = displayPathtoPrincess(n, grid, r, c, print = false)
                .split("\n")
                .first

  print direction
end

def stand_alone_next_move(n, r, c, grid)
  p_row, p_col = find_char_coordinates("p", grid)
  if r < p_row
    print "DOWN"; return nil
  elsif r > p_row
    print "UP"; return nil
  elsif c > p_col
    print "LEFT"; return nil
  elsif c < p_col
    print "RIGHT"; return nil
  end
end

def find_char_coordinates(char, grid)
  col_index = nil
  row_index = grid.index{|row| col_index = row.index(char)}

  [row_index, col_index]
end
