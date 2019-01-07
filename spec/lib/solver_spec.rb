require './lib/solver'
require './lib/maze'

describe Solver do
  describe '#solved_paths' do
    it do
      matrix = Maze.new(
        "XXXXXOX\n" \
        "XOOOOOX\n" \
        "XOXXXOX\n" \
        "XOXXXOX\n" \
        "XOOOOSX\n" \
        "XXXXXXX"
      )
      expected = [[5, 0], [5, 1], [5, 2], [5, 3], [5, 4]]
      initial_cell = Cell.new(5,4, matrix.cells)
      result = Solver.new(initial_cell).solved_paths.shortest
      expect(result).to match_array(expected)
    end
  end
end