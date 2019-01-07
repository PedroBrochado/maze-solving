class Node
  attr_reader :parent, :cells

  def initialize(z, y, x, cells, parent = nil)
    @cells = cells
    @parent = parent
    @x = x
    @y = y
    @z = z
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
    @cells[z][y][x]
  end

  def root?
    @parent.nil?
  end

  def edge?
    right_plane? || left_plane? || top_plane? || bottom_plane? || front_plane? || back_plane?
  end

  def ==(o)
    return o.value == value if o.is_a?(Node)
    o == value
  end

  def coords
    [z,y,x]
  end

  private
  
  attr_reader :x, :y, :z

  def neighbours
    @neighbours ||= [up, down, left, right,front,back].compact.reject{|n| n.coords == @parent&.coords }
  end

  def right
    Node.new(z, y, x+1, @cells, self) unless right_plane?
  end
  
  def left
    Node.new(z, y, x-1, @cells, self) unless left_plane?
  end

  def up
    Node.new(z-1, y, x, @cells, self) unless top_plane?
  end

  def down
    Node.new(z+1, y, x, @cells, self) unless bottom_plane?
  end

  def front
    Node.new(z, y-1, x, @cells, self) unless front_plane?
  end

  def back
    Node.new(z, y+1, x, @cells, self) unless back_plane?
  end

  def value=(v)
    @cells[z][y][x] = v
  end

  def red!
    self.value = "\e[#{31}m#{value}\e[0m"
  end

  def max_x
    @cells.first.first.length - 1
  end

  def max_y
    @cells.first.length - 1
  end

  def max_z
    @cells.length - 1
  end

  def top_plane?; z.zero?; end
  def bottom_plane?; z == max_z; end
  def left_plane?; x.zero?; end
  def right_plane?; x == max_x; end
  def front_plane?; y.zero?; end
  def back_plane?; y == max_y; end

  public

  class Error < StandardError; end
  class CantRevisitCell < Error; end
  class InvalidParent < Error; end

end

