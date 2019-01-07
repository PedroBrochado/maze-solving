require './lib/cell'

describe Cell do
  let(:matrix) { [[1,2,3], [4,5,6], [7,8,9]] }
  # [1,2,3]
  # [4,5,6]
  # [7,8,9]  

  describe '#initialize' do
    it do
      expect(Cell.new(0, 0, matrix).value).to be(1)
      expect(Cell.new(0, 1, matrix).value).to be(4)
      expect(Cell.new(0, 2, matrix).value).to be(7)
      expect(Cell.new(1, 0, matrix).value).to be(2)
      expect(Cell.new(1, 1, matrix).value).to be(5)
      expect(Cell.new(1, 2, matrix).value).to be(8)
      expect(Cell.new(2, 0, matrix).value).to be(3)
      expect(Cell.new(2, 1, matrix).value).to be(6)
      expect(Cell.new(2, 2, matrix).value).to be(9)
    end

    it do
      expect{Cell.new(-42, 0, matrix)}.to raise_error(Cell::InvalidXIndex)
      expect{Cell.new(42, 0, matrix)}.to raise_error(Cell::InvalidXIndex)
      expect{Cell.new(0, 42, matrix)}.to raise_error(Cell::InvalidYIndex)
      expect{Cell.new(0, -42, matrix)}.to raise_error(Cell::InvalidYIndex)
    end
  end

  describe '#edge?' do
    it do
      expect(Cell.new(0, 0, matrix).edge?).to be(true)
      expect(Cell.new(0, 1, matrix).edge?).to be(true)
      expect(Cell.new(0, 2, matrix).edge?).to be(true)
      expect(Cell.new(1, 0, matrix).edge?).to be(true)
      expect(Cell.new(1, 1, matrix).edge?).to be(false)
      expect(Cell.new(1, 2, matrix).edge?).to be(true)
      expect(Cell.new(2, 0, matrix).edge?).to be(true)
      expect(Cell.new(2, 1, matrix).edge?).to be(true)
      expect(Cell.new(2, 2, matrix).edge?).to be(true)
    end      
  end

  describe '#right' do
    it do
      expect(Cell.new(0, 0, matrix).send(:right)).to eq(2)
      expect(Cell.new(1, 1, matrix).send(:right)).to eq(6)
      expect(Cell.new(2, 2, matrix).send(:right)).to be(nil)
      expect(Cell.new(2, 0, matrix).send(:right)).to be_nil
      expect(Cell.new(2, 1, matrix).send(:right)).to be_nil
      expect(Cell.new(2, 2, matrix).send(:right)).to be_nil
      expect(Cell.new(2, 1, matrix).send(:right)).to be_nil
    end
  end

  describe '#left' do
    it do
      expect(Cell.new(1, 1, matrix).send(:left)).to eq(4)
      expect(Cell.new(0, 0, matrix).send(:left)).to be_nil
      expect(Cell.new(2, 1, matrix).send(:left)).to eq(5)
    end
  end

  describe '#up' do
    it do
      expect(Cell.new(1, 1, matrix).send(:up)).to eq(2)
      expect(Cell.new(0, 0, matrix).send(:up)).to be_nil
      expect(Cell.new(1, 0, matrix).send(:up)).to be_nil
      expect(Cell.new(2, 0, matrix).send(:up)).to be_nil
      expect(Cell.new(2, 1, matrix).send(:up)).to eq(3)
    end
  end

  describe '#down' do
    it do
      expect(Cell.new(2, 0, matrix).send(:down)).to eq(6)
      expect(Cell.new(1, 1, matrix).send(:down)).to eq(8)
      expect(Cell.new(0, 2, matrix).send(:down)).to be_nil
      expect(Cell.new(0, 2, matrix).send(:down)).to be_nil
      expect(Cell.new(1, 2, matrix).send(:down)).to be_nil
      expect(Cell.new(2, 2, matrix).send(:down)).to be_nil
      expect(Cell.new(2, 1, matrix).send(:down)).to eq(9)
    end
  end

  describe '#open?' do
    it do
      matrix = [['X', 'O', 'X'], ['X', 'O', 'X'], ['X', 'S', 'X']]
      expect(Cell.new(0, 0, matrix).open?).to be(false)
      expect(Cell.new(0, 1, matrix).open?).to be(false)
      expect(Cell.new(0, 2, matrix).open?).to be(false)
      expect(Cell.new(1, 0, matrix).open?).to be(true)
      expect(Cell.new(1, 1, matrix).open?).to be(true)
      expect(Cell.new(1, 2, matrix).open?).to be(false)
      expect(Cell.new(2, 0, matrix).open?).to be(false)
      expect(Cell.new(2, 1, matrix).open?).to be(false)
      expect(Cell.new(2, 2, matrix).open?).to be(false)
    end
  end

  describe '#visited?' do
    it do
      matrix = [['X', 'O', 'X'], ['V', 'O', 'X'], ['X', 'S', 'V']]
      expect(Cell.new(0, 0, matrix).visited?).to be(false)
      expect(Cell.new(0, 1, matrix).visited?).to be(true)
      expect(Cell.new(0, 2, matrix).visited?).to be(false)
      expect(Cell.new(1, 0, matrix).visited?).to be(false)
      expect(Cell.new(1, 1, matrix).visited?).to be(false)
      expect(Cell.new(1, 2, matrix).visited?).to be(false)
      expect(Cell.new(2, 0, matrix).visited?).to be(false)
      expect(Cell.new(2, 1, matrix).visited?).to be(false)
      expect(Cell.new(2, 2, matrix).visited?).to be(true)
    end
  end

  describe '#visit!' do
    it do
      matrix = [['X', 'X', 'X'], ['X', 'X', 'X'], ['X', 'X', 'X']]
      Cell.new(0, 0, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(0, 1, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(0, 2, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(1, 0, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(1, 1, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(1, 2, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(2, 0, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(2, 1, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
      Cell.new(2, 2, matrix).visit!; expect(Cell.new(0, 0, matrix).visited?).to be(true)
    end
  end

  describe '#neighbours' do
    it 'includes all neighbours when intialized as root' do
      matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
      result = Cell.new(1, 1, matrix).send(:neighbours).map(&:value)
      expect(result).to match_array([2,8,4,6])
    end

    it 'excludes parent when intialized as children' do
      matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
      parent = Cell.new(1, 1, matrix)
      result =  Cell.new(0, 1, matrix, parent).send(:neighbours).map(&:value)
      expect(result).to match_array([1,7])
    end
  end

  describe 'open_neighbours' do
    it do
      matrix = [['X', 'O', 'X'], ['O', 'S', 'X'], ['X', 'X', 'X']]
      result = Cell.new(1, 1, matrix).open_neighbours.map(&:coords)
      expect(result).to match_array([[0,1],[1,0]])
    end
  end

  describe 'visited_neighbours' do
    it do
      matrix = [['X', 'V', 'X'], ['V', 'S', 'X'], ['X', 'X', 'X']]
      result = Cell.new(1, 1, matrix).visited_neighbours.map(&:coords)
      expect(result).to match_array([[0,1],[1,0]])
    end
  end

  describe '#root?' do
    it 'returns true when cell is initialized without a parent' do
      expect(Cell.new(1, 1, matrix).root?).to be(true)
    end

    it 'returns false when cell is initialized with a parent' do
      parent = Cell.new(1,1,matrix)
      result = Cell.new(1, 1, matrix, parent)
      expect(result.root?).to be(false)
    end
  end
end