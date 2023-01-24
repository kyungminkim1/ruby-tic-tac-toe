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
    if matching_row?(player) || matching_column?(player) || matching_diagonal?(player)
      # announce victory for player 1/2
      announce_victory
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

  def matching_row?(player)
    # check top row
    if @board_space[0][0] == player.symbol && @board_space[0][1] == player.symbol && @board_space[0][2] == player.symbol
      return true
    # check middle row
    elsif @board_space[1][0] == player.symbol && @board_space[1][1] == player.symbol && @board_space[1][2] == player.symbol
      return true
    # check bottom row
    elsif @board_space[2][0] == player.symbol && @board_space[2][1] == player.symbol && @board_space[2][2] == player.symbol
      return true
    end

    false
  end

  def matching_column?(player)
    # check left column
    if @board_space[0][0] == player.symbol && @board_space[1][0] == player.symbol && @board_space[2][0] == player.symbol
      return true
    # check middle column
    elsif @board_space[0][1] == player.symbol && @board_space[1][1] == player.symbol && @board_space[2][1] == player.symbol
      return true
    # check right column
    elsif @board_space[0][2] == player.symbol && @board_space[1][2] == player.symbol && @board_space[2][2] == player.symbol
      return true
    end

    false
  end

  def announce_victory

  end

  def announce_draw

  end

end

class Piece
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

class Player
  attr_reader :piece

  def initialize(piece_symbol)
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
player_one = Player.new('x')
b.add_piece(player_one.piece, 0, 0)
b.print_board
b.add_piece(player_one.piece, 0, 0)
