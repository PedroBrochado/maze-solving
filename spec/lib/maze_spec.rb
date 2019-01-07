require './lib/maze'

describe Maze do
    describe '#from_file' do
    it do
      expect { Maze.from_file('./spec/fixtures/sample.txt') }.to(
        output(
          "X\e[31mV\e[0mXXXX\n" \
          "X\e[31mV\e[0mXOOX\n" \
          "X\e[31mV\e[0mXOXX\n" \
          "X\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0mX\n" \
          "XXXXXX"
          ).to_stdout
      )
    end

    it 'raises error for invalid mazes' do 
      expect{ Maze.from_file('./spec/fixtures/invalid.txt') }.to raise_error(
        Maze::InvalidCurrentPosition
      )
    end
  end

  describe '#all paths' do
    it do
      expected = "XXXXX\e[31mV\e[0mX\n" \
                 "X\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0mX\n" \
                 "X\e[31mV\e[0mXXX\e[31mV\e[0mX\n" \
                 "X\e[31mV\e[0mXXX\e[31mV\e[0mX\n" \
                 "X\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0m\e[31mV\e[0mX\n" \
                 "XXXXXXX"
        expect { Maze.from_file('./spec/fixtures/multiple.txt') }.to(
          output(expected).to_stdout
        )
      end
  end

  describe '#shortest path' do
    it do
      expected =  "XXXXX\e[31mV\e[0mX\n" \
                  "XOOOO\e[31mV\e[0mX\n" \
                  "XOXXX\e[31mV\e[0mX\n" \
                  "XOXXX\e[31mV\e[0mX\n" \
                  "XOOOO\e[31mV\e[0mX\n" \
                  "XXXXXXX"
      expect { Maze.from_file('./spec/fixtures/multiple.txt', {shortest: true}) }.to(
        output(expected).to_stdout
      )
    end
  end

  describe '#initial_cell' do
    it do
      maze = Maze.new("XOX\nXOX\nXSX")
      expect(maze.send(:initial_cell)).to eq('S')
    end
  end

  describe '#print' do
    it do
      maze = Maze.new("XOX\nXOX\nXSX")
      expect { maze.print }.to(
        output("X\e[31mV\e[0mX\nX\e[31mV\e[0mX\nX\e[31mV\e[0mX").to_stdout
      )
    end
  end

  describe 'edge cases' do
    it 'dead end' do
      maze = Maze.new(
        "XXX\n" \
        "XOX\n" \
        "XSX\n" \
        "XXX"
      )
      expect { maze.print }.to raise_error(Solver::CouldNotSolve)
    end
  end
end