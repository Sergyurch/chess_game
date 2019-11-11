module ComputerToPlayer
  def computer_to_player(player1 = nil, player2 = nil, current_turn = nil, board = nil)
    @current_game = 'CP'
    @player1 = player1
    @player2 = player2
    @current_turn = current_turn
    @board = board
    
    if player1 == nil
      puts 'Please, enter your name'
      @player1 = Player.new(gets.chomp, 'white')
      puts "Hi, #{@player1.name}, your team is #{@player1.team}"
      @player2 = Player.new('COMPUTER', 'black')
      puts "Computer's team is #{@player2.team}"
      @current_turn = @player1
      @board = Board.new
    end
    
    @board.show
    
    while true
      if @current_turn == @player1
        puts "#{@current_turn.name}, please choose a figure. Enter coordinates, for example 'a1'"
        coordinates_from = check_coordinates(gets.chomp)
        figure = @board.cells[coordinates_from].content
        possible_moves = get_possible_moves(figure)
      
        while figure.instance_of?(String) || figure.team != @current_turn.team || possible_moves == []
          puts 'It is an empty cell or this figure is not from your team or this figure does not have legal moves. Try again, please.'
          coordinates_from = check_coordinates(gets.chomp)
          figure = @board.cells[coordinates_from].content
          possible_moves = get_possible_moves(figure)
        end
      else
        computer_figures = []
        
        @board.cells.each do |key, cell|
          if (!cell.content.instance_of? String) && (cell.content.team == @current_turn.team) && (get_possible_moves(cell.content) != [])
            computer_figures.push(cell.content)
          end
        end
        
        figure = computer_figures[rand(computer_figures.length)]
        coordinates_from = "#{figure.y_coord}#{figure.x_coord}"
        puts "#{@current_turn.name} chose figure in the cell #{coordinates_from}."
        sleep(2)
      end
      
      if @current_turn == @player1
        puts "#{@current_turn.name}, enter coordinates you want to move the figure to"
        coordinates_to = check_coordinates(gets.chomp)
      
        until possible_moves.include?(coordinates_to)
          puts "It is illegal move. Try again, please."
          coordinates_to = check_coordinates(gets.chomp)
        end
      else
        possible_moves = get_possible_moves(figure)
        coordinates_to = possible_moves[rand(possible_moves.length)]
      end
      
      pawn_to_queen(figure, coordinates_to)
      puts "#{@current_turn.name} moved #{figure.class.to_s} from #{coordinates_from} to #{coordinates_to}"
      sleep(2)
      return if commit_changes(coordinates_from, coordinates_to) == 'Game over'
    end
  end
end