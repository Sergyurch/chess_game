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
          @cells["#{y}#{8-x}"].color = 'gray'
        else
          @cells["#{y}#{8-x}"].color = 'brown'
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
          print colorize(@cells["#{y}#{8-x}"].content, @cells["#{y}#{8-x}"].color, @cells["#{y}#{8-x}"].color)
        else
          print colorize(@cells["#{y}#{8-x}"].content.figure, 'dark gray', @cells["#{y}#{8-x}"].color)
        end
      end
      
      puts " #{8-x}"
    end
    
    puts '  a b c d e f g h  '
  end
  
  def colorize(text, color = "default", bgColor = "default")
    colors = {"default" => "38","black" => "30","red" => "31","green" => "32","brown" => "33", "blue" => "34", "purple" => "35",
     "cyan" => "36", "gray" => "37", "dark gray" => "1;30", "light red" => "1;31", "light green" => "1;32", "yellow" => "1;33",
      "light blue" => "1;34", "light purple" => "1;35", "light cyan" => "1;36", "white" => "1;37"}
    bgColors = {"default" => "0", "black" => "40", "red" => "41", "green" => "42", "brown" => "43", "blue" => "44",
     "purple" => "45", "cyan" => "46", "gray" => "47", "dark gray" => "100", "light red" => "101", "light green" => "102",
     "yellow" => "103", "light blue" => "104", "light purple" => "105", "light cyan" => "106", "white" => "107"}
    color_code = colors[color]
    bgColor_code = bgColors[bgColor]
    return "\033[#{bgColor_code};#{color_code}m#{text}\033[0m"
  end
end