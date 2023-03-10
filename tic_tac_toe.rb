# Recreate tic-tac-toe using Ruby
# Things to consider:
# - classes:
# -- Player
# -- Board
# -- Piece
# -- Game (manages game loop)

# - instance variables:
# -- Player:
# --- @piece_type = Piece.new
# -- Board:
# --- @@board_space
# -- Piece:
# --- @symbol


# - methods:
# Player
# -- place_piece
# Board:
# -- declare_result
# -- wait_for_turn
# -- check_rows
# -- check_columns
# -- check_diagonals
# -- print_board
# -- get_player_input

class Board
  attr_accessor :board_space

  def initialize
    # Remember:  Array.new(3, Array.new(3)) will have the
    # indices sharing the same reference!
    @board_space = Array.new(3) { Array.new(3, ' ') }
  end

  def add_piece(piece, row_index, column_index)
    if space_available?(row_index, column_index)
      @board_space[row_index][column_index] = piece.symbol
    else
      puts 'That space has already been filled!'
    end
  end

  def print_board
    puts
    @board_space.map { |row| puts row.to_s }
  end

  def player_won?(player)
    matching_row?(player.piece) ||
      matching_column?(player.piece) ||
      matching_diagonal?(player.piece)
  end

  def board_full?
    available_space = @board_space.flatten.select { |space| space == ' ' }
    available_space == []
  end

  private

  def space_available?(row_index, column_index)
    @board_space[row_index][column_index] == ' '
  end

  def matching_row?(piece)
    # check top row
    if @board_space[0][0] == piece.symbol &&
       @board_space[0][1] == piece.symbol &&
       @board_space[0][2] == piece.symbol
      return true
    # check middle row
    elsif @board_space[1][0] == piece.symbol &&
          @board_space[1][1] == piece.symbol &&
          @board_space[1][2] == piece.symbol
      return true
    # check bottom row
    elsif @board_space[2][0] == piece.symbol &&
          @board_space[2][1] == piece.symbol &&
          @board_space[2][2] == piece.symbol
      return true
    end

    false
  end

  def matching_column?(piece)
    # check left column
    if @board_space[0][0] == piece.symbol &&
       @board_space[1][0] == piece.symbol &&
       @board_space[2][0] == piece.symbol
      return true
    # check middle column
    elsif @board_space[0][1] == piece.symbol &&
          @board_space[1][1] == piece.symbol &&
          @board_space[2][1] == piece.symbol
      return true
    # check right column
    elsif @board_space[0][2] == piece.symbol &&
          @board_space[1][2] == piece.symbol &&
          @board_space[2][2] == piece.symbol
      return true
    end

    false
  end

  def matching_diagonal?(piece)
    # check top-left to bottom-right diagonal
    if @board_space[0][0] == piece.symbol &&
       @board_space[1][1] == piece.symbol &&
       @board_space[2][2] == piece.symbol
      return true
    # check top-right to bottom-left diagonal
    elsif @board_space[0][2] == piece.symbol &&
          @board_space[1][1] == piece.symbol &&
          @board_space[2][0] == piece.symbol
      return true
    end

    false
  end
end

class Piece
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end

end

class Game
  attr_reader :board, :game_ended

  def initialize(board)
    @board = board
    @game_ended = false
  end

  def check_board(player)
    if @board.player_won?(player)
      # announce victory for player 1 or 2
      announce_victory(player)
      @game_ended = true
    elsif @board.board_full?
      # end game on a draw
      announce_draw
    else
      # continue game
      puts "#{player.name} has ended their turn."
    end
    @board.print_board
  end

  def get_index_input(string)
    puts "Which #{string} (from 0 to 2)?"
    case string
    when 'row'
      puts "0 = top #{string}, 2 = bottom #{string}"
    when 'column'
      puts "0 = left #{string}, 2 = right #{string}"
    else
      'YOU SHOULD NOT HAVE GOTTEN THIS'
    end
    index_input = gets.chomp
    until %w[0 1 2].include?(index_input)
      puts "That's not a valid input!"
      puts
      puts "Which #{string} (from 0 to 2)?"
      index_input = gets.chomp
    end
    puts 'Input accepted!'
    puts
    index_input.to_i
  end

  private

  def announce_victory(player)
    puts '""""""""""""""""""""""'
    puts "\"\"\"\"#{player.name} wins!\"\"\"\""
    puts '""""""""""""""""""""""'
  end

  def announce_draw
    puts "There's no more space! It's a draw!"
  end
end

player_one = Player.new('Player 1', Piece.new('x'))
player_two = Player.new('Player 2', Piece.new('o'))
game = Game.new(Board.new)
is_player_ones_turn = true

until game.game_ended
  current_player = is_player_ones_turn ? player_one : player_two
  is_player_ones_turn = !is_player_ones_turn
  puts "It's #{current_player.name}'s turn!"
  row_index = game.get_index_input('row')
  column_index = game.get_index_input('column')
  game.board.add_piece(current_player.piece, row_index, column_index)
  game.check_board(current_player)
end
