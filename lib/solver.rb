require_relative 'solved_paths'

class Solver
  attr_reader :solved_paths
  # Soluition from the end to the begin
  # First call run on all nodes with children, when an edge (goal)
  # is found visit it, then mark all linked nodes as visited, an so on
  # if root node has no marked neighbours there is no solution  
  def initialize(cell, visited_cells = [])
    visited_cells = visited_cells
    cell.open_neighbours.each { |n| Solver.new(n, visited_cells) }
    if cell.edge? || cell.visited_neighbours.any?
      cell.visit!
      # build_visited_cells_map
      visited_cells.push(node: cell.coords, parent: cell.parent&.coords)
    end
    if cell.root? 
      raise Solver::CouldNotSolve if cell.visited_neighbours.empty?
      @solved_paths = SolvedPaths.new(visited_cells)
    end
  end

  class CouldNotSolve < StandardError; end
end
