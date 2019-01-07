require_relative 'solver'
require_relative 'cell'

class Maze
  attr_accessor :cells

  def initialize(content)
    @cells = content.split("\n").map{ |l| l.split('') }
  end

  def self.solve_and_print_detail(path)    
    maze = new(File.read(path))
    puts 'All Paths:'
    maze.print
    puts
    puts 'Shortest Path:'
    maze.print_shortest
    puts
  end

  def self.from_file(path, options = {})
    maze = new(File.read(path))
    if options.has_key?(:shortest)
      maze.print_shortest
    else
      maze.print
    end
  end

  def print
    cells = clone_cells
    solve.all.each { |path| set_path(cells, path) }
    Kernel.send(:print, cells.map(&:join).join("\n"))
  end

  def print_shortest
    cells = clone_cells
    set_path(cells, solve.shortest)
    Kernel.send(:print, cells.map(&:join).join("\n"))
  end

  class InvalidCurrentPosition < StandardError; end

  private

  def clone_cells
    @cells.map{|l| l.dup}.dup
  end

  def set_path(cells, path)
    path.each do |node|
      cells[node.last][node.first] = "\e[31mV\e[0m"
    end
  end

  def solve
    @paths ||= Solver.new(initial_cell).solved_paths
  end

  def initial_cell
    @cells.each_with_index do |line, index|
      return Cell.new(line.index('S'), index, clone_cells) if line.include?('S')
    end
    raise InvalidCurrentPosition
  end

  def to_s
    @cells.map(&:join).join("\n")
  end
end
