def displayPathtoPrincess(n, grid, m_row = nil, m_col = nil, print = true)
  p_row, p_col = find_char_coordinates("p", grid)
  m_row, m_col = find_char_coordinates("m", grid) unless m_col && m_row

  row_diff = m_row - p_row
  col_diff = m_col - p_col

  go_down = row_diff < 0
  go_right = col_diff < 0

  directions = ''
  directions += go_down ? "DOWN\n" * row_diff.abs : "UP\n" * row_diff
  directions += go_right ? "RIGHT\n" * col_diff.abs : "LEFT\n" * col_diff

  if print
    print directions.chomp
  else
    return directions.chomp
  end

end


def nextMove(n, r, c, grid)
  direction = displayPathtoPrincess(n, grid, r, c, print = false)
                .split("\n")
                .first

  print direction
end


def find_char_coordinates(char, grid)
  col_index = nil
  row_index = grid.index{|row| col_index = row.index(char)}

  [row_index, col_index]
end
