require './lib/node'

describe Node do
  let(:matrix) do
    [
      [
        [1,2,3],[4,5,6],[7,8,9]
      ],
      [
        [10,11,12],[13,14,15],[16,17,18]
      ],
      [
        [19,20,21],[22,23,24],[25,26,27]
      ]
    ]
  end

  let(:maze) do
    [
      [['X', 'X', 'X'], ['X', 'O', 'X'], ['X', 'X', 'X']],
      [['X', 'V', 'X'], ['X', 'O', 'V'], ['X', 'O', 'X']],
      [['V', 'X', 'X'], ['X', 'S', 'X'], ['X', 'X', 'X']]
    ]
  end

  describe '#initialize' do
    it do
      expect(Node.new(0, 0, 0, matrix).value).to eq(1)
      expect(Node.new(1, 1, 1, matrix).value).to eq(14)
      expect(Node.new(2, 2, 2, matrix).value).to eq(27)
      expect(Node.new(2, 1, 2, matrix).value).to eq(24)
    end
  end

  describe '#edge?' do
    it do
      expect(Node.new(1, 1, 1,  matrix).edge?).to be(false)
      expect(Node.new(1, 0, 0, matrix).edge?).to be(true)
      expect(Node.new(0, 1, 0, matrix).edge?).to be(true)
      expect(Node.new(0, 0, 1, matrix).edge?).to be(true)
    end      
  end

  describe '#right' do
    it do
      expect(Node.new(2, 2, 2, matrix).send(:right)).to be_nil
      expect(Node.new(0, 0, 1, matrix).send(:right)).to eq(3)
      expect(Node.new(1, 1, 1, matrix).send(:right)).to eq(15)
    end
  end

  describe '#left' do
    it do
      expect(Node.new(0, 0, 0, matrix).send(:left)).to be_nil
      expect(Node.new(0, 0, 1, matrix).send(:left)).to eq(1)
      expect(Node.new(1, 1, 1, matrix).send(:left)).to eq(13)
    end
  end

  describe '#up' do
    it do
      expect(Node.new(2, 2, 2, matrix).send(:up)).to eq(18)
      expect(Node.new(0, 0, 1, matrix).send(:up)).to be_nil
      expect(Node.new(1, 1, 1, matrix).send(:up)).to eq(5)
    end
  end

  describe '#down' do
    it do
      expect(Node.new(2, 2, 2, matrix).send(:down)).to be_nil
      expect(Node.new(0, 0, 1, matrix).send(:down)).to eq(11)
      expect(Node.new(1, 1, 1, matrix).send(:down)).to eq(23)
    end
  end

  describe '#front' do
    it do
      expect(Node.new(2, 2, 2, matrix).send(:front).value).to be(24)
      expect(Node.new(0, 0, 1, matrix).send(:front)).to be_nil
      expect(Node.new(1, 1, 1, matrix).send(:front)).to eq(11)
    end
  end

  describe '#back' do
    it do
      expect(Node.new(2, 2, 2, matrix).send(:back)).to be_nil
      expect(Node.new(0, 0, 1, matrix).send(:back)).to eq(5)
      expect(Node.new(1, 1, 1, matrix).send(:back)).to eq(17)
    end
  end

  describe '#open?' do
    it do
      expect(Node.new(0, 0, 0, maze).open?).to be(false)
      expect(Node.new(1, 1, 1, maze).open?).to be(true)
      expect(Node.new(2, 2, 2, maze).open?).to be(false)

    end
  end

  describe '#visited?' do
    it do
      expect(Node.new(2, 0, 0, maze).visited?).to be(true)
      expect(Node.new(2, 2, 2, maze).visited?).to be(false)
      expect(Node.new(1, 1, 2, maze).visited?).to be(true)

    end
  end

  describe '#visit!' do
    it do
      Node.new(0, 0, 0, maze).visit!; expect(Node.new(0, 0, 0, maze).visited?).to be(true)
      Node.new(0, 1, 0, maze).visit!; expect(Node.new(0, 1, 0, maze).visited?).to be(true)
    end
  end

  describe '#neighbours' do
    it 'includes all neighbours when intialized as root' do
      result = Node.new(1, 1, 1, matrix).send(:neighbours).map(&:value)
      expect(result).to match_array([5,13,15,23,11,17])
    end

    it 'excludes parent when intialized as children' do
      parent = Node.new(1, 1, 0, matrix)
      result =  Node.new(1, 1, 1, matrix, parent).send(:neighbours).map(&:value)
      expect(result).to match_array([5,15,23,11,17])
    end
  end

  describe 'open_neighbours' do
    it do
      result = Node.new(1, 1, 1, maze).open_neighbours.map(&:coords)
      expect(result).to match_array([[0,1,1],[1,2,1]])
    end
  end

  describe 'visited_neighbours' do
    it do
      result = Node.new(1, 1, 1, maze).visited_neighbours.map(&:coords)
      expect(result).to match_array([[1,0,1],[1,1,2]])
    end
  end

  describe '#root?' do
    it 'returns true when cell is initialized without a parent' do
      expect(Node.new(1, 1, 1, matrix).root?).to be(true)
    end

    it 'returns false when cell is initialized with a parent' do
      parent = Node.new(1, 1, 1, matrix)
      result = Node.new(1, 1, 0, matrix, parent).root?
      expect(result).to be(false)
    end
  end
end