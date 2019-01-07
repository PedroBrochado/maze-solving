class SolvedPaths
  def initialize(visited_cells)
    @paths = cells_to_paths(visited_cells.dup)
  end
  
  def all
    @paths
  end
  
  def shortest
    index_of_shortest_path = @paths.map(&:size).each_with_index.min.last
    @paths[index_of_shortest_path]
  end

  private

  def root(cells)
    cells.find{|n| n[:parent].nil?}[:node]
  end

  def cells_to_paths(cells)
    result = []
    root = root(cells)
    initial_of_path_indexes = cells.each_index.select{|i| cells[i][:parent] == root}
    while(initial_of_path_indexes.any?) do
      i = initial_of_path_indexes.shift
      path = cells.shift(i+1).map{|e| e[:node]}.push(root)
      result.push(path)
    end
    result
  end

end