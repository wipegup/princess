def displayPathtoPrincess(n, grid)
  p_col = nil
  p_row = grid.index{|row| p_col = row.index("p")}

  m_col = m_row = n / 2

  row_diff = m_row - p_row
  col_diff = m_col - p_col

  directions = ''

  directions += "DOWN\n" * row_diff.abs if row_diff < 0
  directions += "UP\n" * row_diff if row_diff > 0

  directions += "RIGHT\n" * col_diff.abs if col_diff < 0
  directions += "LEFT\n" * col_diff if col_diff  > 0

  print directions.chomp
  return directions
end
