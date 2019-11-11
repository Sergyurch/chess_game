require_relative 'game_elements'
require_relative 'move_rules'
require_relative 'player_to_player'
require_relative 'computer_to_player'
require 'yaml'

class Game
  include MoveRules
  include PlayerToPlayer
  include ComputerToPlayer
  
  def initialize
    show_title
    if File.exists? ('lib/saved_game.txt')
      puts 'There is a saved game. You may continue it or start a new one.'
      sleep(1)
      puts 'If you start a new game, the saved game will be deleted. Would you like to load a saved game (N/Y)?'
      answer = gets.chomp
      
      until answer.match?(/^[n,N,y,Y]$/)
        puts 'Enter only N or Y, please.'
        answer = gets.chomp
      end
      
      answer.match?(/^[n,N]$/) ? start_new_game: continue_game
    else
      start_new_game
    end
  end
  
  private
  
  def show_title
    puts ' ______________________________________'
    sleep(0.2)
    puts '|  ____   _   _   ____   ____   ____   |'
    sleep(0.2)
    puts '| |  __| | | | | |  __| |  __| |  __|  |'
    sleep(0.2)
    puts '| | |    | |_| | | |__  | |__  | |__   |'
    sleep(0.2)
    puts '| | |    |  _  | |  __| |__  | |__  |  |'
    sleep(0.2)
    puts '| | |__  | | | | | |__   __| |  __| |  |'
    sleep(0.2)
    puts '| |____| |_| |_| |____| |____| |____|  |'
    sleep(0.2)
    puts '|______________________________________|'
    sleep(1)
  end
  
  def start_new_game
    puts 'Welcome to chess game.'
    sleep(1)
    puts 'All your progress during the game will be automatically saved.'
    sleep(1)
    puts 'You can exit the game and then continue it at any time.'
    sleep(1)
    puts 'Would you like to play Player-Player or Computer-Player? Answer, please PP or CP'
    answer = gets.chomp
    
    until answer.match?(/^[p,P,c,C][p,P]$/)
      puts 'Enter only PP or CP, please.'
      answer = gets.chomp
    end
    
    answer.match?(/^[p,P][p,P]$/) ? player_to_player: computer_to_player
  end
  
  def continue_game
    data = YAML.load File.read('lib/saved_game.txt')
    
    if data[:current_game] == 'PP'
      player_to_player(data[:player1], data[:player2], data[:current_turn], data[:board])
    else
      computer_to_player(data[:player1], data[:player2], data[:current_turn], data[:board])
    end
  end
  
  def pawn_to_queen(figure, coordinates_to)
    if ( (figure.class.to_s == 'Pawn') && (coordinates_to[1] == '8') && (figure.team == 'white') ) ||
       ( (figure.class.to_s == 'Pawn') && (coordinates_to[1] == '1') && (figure.team == 'black') )
      @board.cells[coordinates_to].content = Queen.new(coordinates_to[0], coordinates_to[1], @current_turn.team)
    else
      @board.cells[coordinates_to].content = figure
    end
  end
  
  def check_coordinates(coordinates)
    until coordinates.match?(/^[a-h,A-H][1-8]$/)
      puts 'There is no cell on the board with these coordinates. Try again, please.'
      coordinates = gets.chomp
    end
    coordinates
  end
  
  def is_game_over?(figure, enemy)
    king = find_king(enemy)
    
    if king == nil
      true
    elsif is_check?(figure ,enemy) == true && get_possible_moves(king) == []
      true
    else
      false
    end
  end
  
  def save_game
    file = File.open('lib/saved_game.txt', 'w')
    file.puts YAML.dump({player1: @player1, player2: @player2, current_turn: @current_turn, current_game: @current_game, board: @board})
    file.close
  end
  
  def is_check?(figure, enemy)
    king = find_king(enemy)
    (get_possible_moves(figure).include?("#{king.y_coord}#{king.x_coord}")) ? true: false
  end
  
  def find_king(player)
    king = nil
    
    @board.cells.each do |key, cell|
      if cell.content.instance_of?(King) && cell.content.team == player.team
        king = cell.content
        break
      end
    end
    
    king
  end
  
  def commit_changes(coordinates_from, coordinates_to)
    figure = @board.cells[coordinates_to].content
    figure.x_coord = coordinates_to[1]
    figure.y_coord = coordinates_to[0]
    @board.cells[coordinates_from].content = "\u2659"
    @board.show
    enemy = (@current_turn == @player1) ? @player2: @player1
      
    if is_game_over?(figure, enemy)
      puts "#{enemy.name}, CHECKMATE for you!!! GAME OVER!!!"
      return 'Game over'
    end
      
    puts "#{enemy.name}, CHECK for you!!!" if is_check?(figure, enemy)
    (@current_turn == @player1) ? @current_turn = @player2: @current_turn = @player1
    save_game
  end

end