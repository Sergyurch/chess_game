module MoveRules
  def get_possible_moves(figure)
    return [] if figure.instance_of? String
    
    result = []
    letters = ['a','b','c','d','e','f','g','h']
    x = figure.x_coord.to_i
    y = letters.index(figure.y_coord)
    
    case figure.class.to_s
      when 'Pawn'
        if figure.team == 'white'
          if (@board.cells["#{letters[y]}#{x + 1}"].content == "\u2659")
            result.push("#{letters[y]}#{x + 1}")
            result.push("#{letters[y]}#{x + 2}") if (figure.x_coord == '2') && (@board.cells["#{letters[y]}#{x + 2}"].content == "\u2659")
          end
        
          [-1, 1].each do |step|
            cell = @board.cells["#{letters[y + step]}#{x + 1}"]
            if (y + step >= 0) && (cell != nil) && (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x + 1}")
            end
          end
        
          return result
        else
          if (@board.cells["#{letters[y]}#{x - 1}"].content == "\u2659")
            result.push("#{letters[y]}#{x - 1}")
            result.push("#{letters[y]}#{x - 2}") if (figure.x_coord == '7') && (@board.cells["#{letters[y]}#{x - 2}"].content == "\u2659")
          end
        
          [-1, 1].each do |step|
            cell = @board.cells["#{letters[y + step]}#{x - 1}"]
            if (y + step >= 0) && (cell != nil) && (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x - 1}")
            end
          end
        
          return result
        end
      when 'Rook'
        up = nil
        down = nil
        right = nil
        left = nil
      
        for step in 1..7
          if up !='stop'
            cell = @board.cells["#{letters[y]}#{x + step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              up = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y]}#{x + step}")
              up = 'stop'
            else
              result.push("#{letters[y]}#{x + step}")
            end
          end
        
          if down !='stop'
            cell = @board.cells["#{letters[y]}#{x - step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              down = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y]}#{x - step}")
              down = 'stop'
            else 
              result.push("#{letters[y]}#{x - step}")
            end
          end
        
          if right !='stop'
            cell = @board.cells["#{letters[y + step]}#{x}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              right = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x}")
              right = 'stop'
            else
              result.push("#{letters[y + step]}#{x}")
            end
          end
        
          if left !='stop'
            cell = @board.cells["#{letters[y - step]}#{x}"]
            
            if cell == nil || (y - step < 0) || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              left = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y - step]}#{x}")
              left = 'stop'
            else
              result.push("#{letters[y - step]}#{x}")
            end
          end
        end  
      
        return result
      
      when 'Knight'
        steps = [[1,2],[1,-2],[2,1],[2,-1],[-1,2],[-1,-2],[-2,1],[-2,-1]]
        
        steps.each do |arr|
          cell = @board.cells["#{letters[y + arr[0]]}#{x + arr[1]}"]
          
          if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
            next
          elsif y + arr[0] >= 0
            result.push("#{letters[y + arr[0]]}#{x + arr[1]}")
          end
        end
        
        return result
        
      when 'Bishop'
        up_right = nil
        down_right = nil
        up_left = nil
        down_left = nil
      
        for step in 1..7
          if up_right !='stop'
            cell = @board.cells["#{letters[y + step]}#{x + step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              up_right = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x + step}")
              up_right = 'stop'
            else
              result.push("#{letters[y + step]}#{x + step}")
            end
          end
          
          if down_right !='stop'
            cell = @board.cells["#{letters[y + step]}#{x - step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              down_right = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x - step}")
              down_right = 'stop'
            else
              result.push("#{letters[y + step]}#{x - step}")
            end
          end
          
          if up_left !='stop'
            cell = @board.cells["#{letters[y - step]}#{x + step}"]
            
            if cell == nil || (y - step < 0) || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              up_left = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y - step]}#{x + step}")
              up_left = 'stop'
            else
              result.push("#{letters[y - step]}#{x + step}")
            end
          end
          
          if down_left !='stop'
            cell = @board.cells["#{letters[y - step]}#{x - step}"]
            
            if cell == nil || (y - step < 0) || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              down_left = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y - step]}#{x - step}")
              down_left = 'stop'
            else
              result.push("#{letters[y - step]}#{x - step}")
            end
          end
        end
        
        return result
      
      when 'Queen'
        up = nil
        down = nil
        right = nil
        left = nil
        up_right = nil
        down_right = nil
        up_left = nil
        down_left = nil
        
        for step in 1..7
          if up !='stop'
            cell = @board.cells["#{letters[y]}#{x + step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              up = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y]}#{x + step}")
              up = 'stop'
            else
              result.push("#{letters[y]}#{x + step}")
            end
          end
          
          if down !='stop'
            cell = @board.cells["#{letters[y]}#{x - step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              down = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y]}#{x - step}")
              down = 'stop'
            else
              result.push("#{letters[y]}#{x - step}")
            end
          end
          
          if right !='stop'
            cell = @board.cells["#{letters[y + step]}#{x}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              right = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x}")
              right = 'stop'
            else
              result.push("#{letters[y + step]}#{x}")
            end
          end
          
          if left !='stop'
            cell = @board.cells["#{letters[y - step]}#{x}"]
            
            if cell == nil || (y - step < 0) || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              left = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y - step]}#{x}")
              left = 'stop'
            else
              result.push("#{letters[y - step]}#{x}")
            end
          end
          
          if up_right !='stop'
            cell = @board.cells["#{letters[y + step]}#{x + step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              up_right = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x + step}")
              up_right = 'stop'
            else
              result.push("#{letters[y + step]}#{x + step}")
            end
          end
          
          if down_right !='stop'
            cell = @board.cells["#{letters[y + step]}#{x - step}"]
            
            if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              down_right = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y + step]}#{x - step}")
              down_right = 'stop'
            else
              result.push("#{letters[y + step]}#{x - step}")
            end
          end
          
          if up_left !='stop'
            cell = @board.cells["#{letters[y - step]}#{x + step}"]
            
            if cell == nil || (y - step < 0) || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              up_left = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y - step]}#{x + step}")
              up_left = 'stop'
            else
              result.push("#{letters[y - step]}#{x + step}")
            end
          end
          
          if down_left !='stop'
            cell = @board.cells["#{letters[y - step]}#{x - step}"]
            
            if cell == nil || (y - step < 0) || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
              down_left = 'stop'
            elsif (cell.content != "\u2659") && (cell.content.team != @current_turn.team)
              result.push("#{letters[y - step]}#{x - step}")
              down_left = 'stop'
            else
              result.push("#{letters[y - step]}#{x - step}")
            end
          end
        end
        
        return result
      
      when 'King'  
        steps = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
        
        steps.each do |arr|
          cell = @board.cells["#{letters[y + arr[0]]}#{x + arr[1]}"]
          
          if cell == nil || ( (cell.content != "\u2659") && (cell.content.team == @current_turn.team) )
            next
          elsif y + arr[0] >= 0
            result.push("#{letters[y + arr[0]]}#{x + arr[1]}")
          end
        end
        
        return result
    end
  end

end