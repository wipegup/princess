def displayPathtoPrincess(n, grid, print = true)
  p_row, p_col = find_char_coordinates("p", grid)
  m_row, m_col = find_char_coordinates("m", grid)

  row_diff = m_row - p_row
  col_diff = m_col - p_col

  go_down = row_diff < 0
  go_right = col_diff < 0

  directions = ''
  directions += go_down ? "DOWN\n" * row_diff.abs : "UP\n" * row_diff
  directions += go_right ? "RIGHT\n" * col_diff.abs : "LEFT\n" * col_diff

  print directions.chomp if print
  directions.chomp
end


def nextMove(n, r, c, grid)
  direction = displayPathtoPrincess(n, grid, print = false)
                .split("\n")
                .first

  print direction
  direction
end


def find_char_coordinates(char, grid)
  col_index = nil
  row_index = grid.index{|row| col_index = row.index(char)}

  [row_index, col_index]
end
