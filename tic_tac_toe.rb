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
    @board_space = Array.new(3, Array.new(3, ' '))
  end

  def print_board
    @board_space.map { |row| puts row.to_s }
  end

  def add_piece(piece, row_index, column_index)
    @board_space[row_index][column_index] = piece.symbol
  end

  def check_rows
    
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