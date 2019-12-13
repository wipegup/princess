module TextToGrid
  def path_to_grid(path)
    lines = File.readlines(path, chomp: true)
    start = lines.index{|line| line.index(/[-,m,p]/)}
    lines = lines[start..-1]

    lines
  end
end
