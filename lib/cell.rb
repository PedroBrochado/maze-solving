class Cell
  attr_reader :parent

  def initialize(x, y, cells, parent = nil)
    @cells = cells
    @parent = parent
    raise InvalidXSize unless max_x >= 0
    raise InvalidYSize unless max_y >= 0
    raise InvalidXIndex unless x >= 0 and x <= max_x
    raise InvalidYIndex unless y >= 0 and y <= max_y
    @x = x
    @y = y
  end

  def open_neighbours
    neighbours.select(&:open?)
  end

  def visited_neighbours
    neighbours.select(&:visited?)
  end

  def open?
    value == 'O'
  end
  
  def visited?
    value == 'V' || value == "\e[31mV\e[0m"
  end

  def visit!
    raise CantRevisitCell if value == 'V'
    self.value = 'V'
    red!
  end

  def value
    @cells[y][x]
  end

  def root?
    @parent.nil?
  end

  def edge?
    right_column? || left_column? || top_row? || bottom_row?
  end

  def ==(o)
    return o.value == value if o.is_a?(Cell)
    o == value
  end

  def coords
    [x,y]
  end

  private
  
  attr_reader :x, :y

  def neighbours
    @neighbours ||= [up, down, left, right].compact.reject{|n| n.coords == @parent&.coords }
  end

  def right
    Cell.new(x+1, y, @cells, self) unless right_column?
  end
  
  def left
    Cell.new(x-1, y, @cells, self) unless left_column?
  end

  def up
    Cell.new(x, y-1, @cells, self) unless top_row?
  end

  def down
    Cell.new(x, y+1, @cells, self) unless bottom_row?
  end

  def value=(v)
    @cells[y][x] = v
  end

  def red!
    self.value = "\e[#{31}m#{value}\e[0m"
  end

  def max_x
    @cells.first.length - 1
  end

  def max_y
    @cells.length - 1
  end

  def left_column?; x.zero?; end
  def top_row?; y.zero?; end
  def right_column?; x == max_x; end
  def bottom_row?; y == max_y; end

  public

  class Error < StandardError; end
  class InvalidXIndex < Error; end
  class InvalidYIndex < Error; end
  class InvalidXSize < Error; end
  class InvalidYSize < Error; end
  class CantRevisitCell < Error; end
  class InvalidParent < Error; end

end

