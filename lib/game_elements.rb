require 'colorize'

module GameFigure
  attr_accessor :x_coord, :y_coord, :team, :figure
  
  def initialize(y_coord, x_coord, team)
    @x_coord = x_coord
    @y_coord = y_coord
    @team = team
    @figure = setup_figure
  end
end

class Pawn
  include GameFigure
  
  def setup_figure
    (@team == 'white') ? @figure = "\u2659": @figure = "\u265f"
  end
end

class Rook
  include GameFigure
  
  def setup_figure
    (@team == 'white') ? @figure = "\u2656": @figure = "\u265c"
  end
end

class Knight
  include GameFigure
  
  def setup_figure
    (@team == 'white') ? @figure = "\u2658": @figure = "\u265e"
  end
end

class Bishop
  include GameFigure
  
  def setup_figure
    (@team == 'white') ? @figure = "\u2657": @figure = "\u265d"
  end
end

class Queen
  include GameFigure
  
  def setup_figure
    (@team == 'white') ? @figure = "\u2655": @figure = "\u265b"
  end
end

class King
  include GameFigure
  
  def setup_figure
    (@team == 'white') ? @figure = "\u2654": @figure = "\u265a"
  end
end

class Player
  attr_reader :name, :team
  
  def initialize(name, team)
    @name = name
    @team = team
  end
end

class Cell
  attr_reader :row, :col
  attr_accessor :content, :color
  
  def initialize(row, col, content = "\u2659")
    @row = row
    @col = col
    @content = content
    @color = nil
  end
end

class Board
  attr_accessor :cells
  
  def initialize
    @cells = {}
    
    for x in 0...8
      for y in 'a'..'h'
        @cells["#{y}#{8-x}"] = Cell.new("#{8-x}", "#{y}")
        
        if ( x % 2 == 0 && ("aceg".include? y) ) || ( x % 2 != 0 && ("bdfh".include? y) )
          @cells["#{y}#{8-x}"].color = :white
        else
          @cells["#{y}#{8-x}"].color = :light_yellow
        end
        
        @cells["#{y}#{8-x}"].content = Pawn.new("#{y}", "#{8-x}", 'black') if x == 1
        @cells["#{y}#{8-x}"].content = Pawn.new("#{y}", "#{8-x}", 'white') if x == 6
        @cells["#{y}#{8-x}"].content = Rook.new("#{y}", "#{8-x}", 'black') if (x == 0 && y == 'a') || (x == 0 && y == 'h')
        @cells["#{y}#{8-x}"].content = Rook.new("#{y}", "#{8-x}", 'white') if (x == 7 && y == 'a') || (x == 7 && y == 'h')
        @cells["#{y}#{8-x}"].content = Knight.new("#{y}", "#{8-x}", 'black') if (x == 0 && y == 'b') || (x == 0 && y == 'g')
        @cells["#{y}#{8-x}"].content = Knight.new("#{y}", "#{8-x}", 'white') if (x == 7 && y == 'b') || (x == 7 && y == 'g')
        @cells["#{y}#{8-x}"].content = Bishop.new("#{y}", "#{8-x}", 'black') if (x == 0 && y == 'c') || (x == 0 && y == 'f')
        @cells["#{y}#{8-x}"].content = Bishop.new("#{y}", "#{8-x}", 'white') if (x == 7 && y == 'c') || (x == 7 && y == 'f')
        @cells["#{y}#{8-x}"].content = Queen.new("#{y}", "#{8-x}", 'black') if x == 0 && y == 'd'
        @cells["#{y}#{8-x}"].content = Queen.new("#{y}", "#{8-x}", 'white') if x == 7 && y == 'd'
        @cells["#{y}#{8-x}"].content = King.new("#{y}", "#{8-x}", 'black') if x == 0 && y == 'e'
        @cells["#{y}#{8-x}"].content = King.new("#{y}", "#{8-x}", 'white') if x == 7 && y == 'e'
      end
    end
  end
  
  def show
    puts '  a b c d e f g h  '
    
    for x in 0..7
      print "#{8-x} "
      
      for y in 'a'..'h'
        if @cells["#{y}#{8-x}"].content.instance_of? String
          print @cells["#{y}#{8-x}"].content.colorize(:color => @cells["#{y}#{8-x}"].color, :background => @cells["#{y}#{8-x}"].color)
        else
          print @cells["#{y}#{8-x}"].content.figure.colorize(:background => @cells["#{y}#{8-x}"].color)
        end
      end
      
      puts " #{8-x}"
    end
    
    puts '  a b c d e f g h  '
  end
end