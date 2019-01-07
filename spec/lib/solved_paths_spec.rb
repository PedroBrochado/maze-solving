require './lib/solved_paths'

describe SolvedPaths do
  let(:visited_cells) do
    [
      {:node=>[5, 0], :parent=>[5, 1]},
      {:node=>[5, 1], :parent=>[5, 2]},
      {:node=>[5, 2], :parent=>[5, 3]},
      {:node=>[5, 3], :parent=>[5, 4]},
      {:node=>[4, 1], :parent=>[3, 1]},
      {:node=>[3, 1], :parent=>[2, 1]},
      {:node=>[2, 1], :parent=>[1, 1]},
      {:node=>[1, 1], :parent=>[1, 2]},
      {:node=>[1, 2], :parent=>[1, 3]},
      {:node=>[1, 3], :parent=>[1, 4]},
      {:node=>[1, 4], :parent=>[2, 4]},
      {:node=>[2, 4], :parent=>[3, 4]},
      {:node=>[3, 4], :parent=>[4, 4]},
      {:node=>[4, 4], :parent=>[5, 4]},
      {:node=>[5, 4], :parent=>nil}
    ]
  end
  describe '#shortest' do
    it do
      expected = [[5, 0], [5, 1], [5, 2], [5, 3], [5, 4]]
      result = SolvedPaths.new(visited_cells).shortest
      expect(result).to match_array(expected)
    end
  end

  describe '#all' do
      it do
        expected = [
          [[5, 0], [5, 1], [5, 2], [5, 3], [5, 4]],
          [[4, 1], [3, 1], [2, 1], [1, 1], [1, 2], [1, 3], [1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [5, 4]]
        ]
        result = SolvedPaths.new(visited_cells).all
        expect(result).to match_array(expected)
      end
    end
end