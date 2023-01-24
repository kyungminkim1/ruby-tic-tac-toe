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
    @board_space = Array.new(3) { Array.new(3, ' ') }
  end

  def print_board
    @board_space.map { |row| puts row.to_s }
  end

  def add_piece(piece, row_index, column_index)
    if space_available?(row_index, column_index)
      @board_space[row_index][column_index] = piece.symbol
    else
      puts 'That space has already been filled!'
    end
  end

  # call after player finishes their move
  def check_board(player)
    if matching_row?(player.piece) || matching_column?(player.piece) || matching_diagonal?(player.piece)
      # announce victory for player 1 or 2
      announce_victory(player)
    elsif board_full?
      # end game on a draw
      announce_draw
    else
      # continue game
    end
  end

  private

  def space_available?(row_index, column_index)
    @board_space[row_index][column_index] == ' '
  end

  def matching_row?(piece)
    # check top row
    if @board_space[0][0] == piece.symbol && @board_space[0][1] == piece.symbol && @board_space[0][2] == piece.symbol
      return true
    # check middle row
    elsif @board_space[1][0] == piece.symbol && @board_space[1][1] == piece.symbol && @board_space[1][2] == piece.symbol
      return true
    # check bottom row
    elsif @board_space[2][0] == piece.symbol && @board_space[2][1] == piece.symbol && @board_space[2][2] == piece.symbol
      return true
    end

    false
  end

  def matching_column?(piece)
    # check left column
    if @board_space[0][0] == piece.symbol && @board_space[1][0] == piece.symbol && @board_space[2][0] == piece.symbol
      return true
    # check middle column
    elsif @board_space[0][1] == piece.symbol && @board_space[1][1] == piece.symbol && @board_space[2][1] == piece.symbol
      return true
    # check right column
    elsif @board_space[0][2] == piece.symbol && @board_space[1][2] == piece.symbol && @board_space[2][2] == piece.symbol
      return true
    end

    false
  end

  def matching_diagonal?(piece)
    # check top left-to-bottom right diagonal
    if @board_space[0][0] == piece.symbol && @board_space[1][1] == piece.symbol && @board_space[2][2] == piece.symbol
      return true
    # check top right-to-bottom left diagonal
    elsif @board_space[0][2] == piece.symbol && @board_space[1][1] == piece.symbol && @board_space[2][0] == piece.symbol
      return true
    end
    
    false
  end

  def announce_victory(player)
    puts '""""""""""""""""""""""'
    puts "\"\"\"\"#{player.name} wins!\"\"\"\""
    puts '""""""""""""""""""""""'
    print_board

  end

  def board_full?
    available_space = @board_space.flatten.map { |space| space == ' ' }
    available_space.all? { |space| space == false }
  end

  def announce_draw
    puts "There's no more space! It's a draw!"
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

  def initialize(name, piece_symbol)
    @name = name
    @piece = Piece.new(piece_symbol)
  end

end

class Game
  def initialize
    @board = Board.new
    @player_one = Player.new('x')
    @player_two = Player.new('o')
  end


end

b = Board.new
b.print_board
player_one = Player.new('Player 1', 'x')
player_two = Player.new('Player 2', 'o')
b.add_piece(player_one.piece, 0, 0)
b.print_board
b.add_piece(player_one.piece, 0, 0)
b.add_piece(player_two.piece, 1, 0)
b.add_piece(player_one.piece, 2, 0)
b.add_piece(player_one.piece, 0, 1)
b.add_piece(player_two.piece, 1, 1)
b.add_piece(player_one.piece, 2, 1)
b.add_piece(player_two.piece, 0, 2)
b.add_piece(player_one.piece, 1, 2)
b.add_piece(player_two.piece, 2, 2)
b.print_board
b.check_board(player_one)