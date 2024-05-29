require_relative "lib/player"
require_relative "lib/board"
require_relative "lib/game"

puts "Welcome to Tic Tac Toe!\n\n"
print "Player One Name: "
player_one_name = gets.chomp
puts "\n" 
print "Player Two Name: "
player_two_name = gets.chomp
puts "\n" 

player_one = Player.new(player_one_name, "X")
player_two = Player.new(player_two_name, "O")
board = Board.new
game = Game.new

board.display_board
until game.game_over
    player_one_move = player_one.make_move(board.board_display)
    board.place_here(player_one_move, player_one.piece)
    if game.in_a_row?(player_one.placed_pieces, player_one.name)
        break
    elsif game.full_board?(player_one.placed_pieces, player_two.placed_pieces)
        break
    end
    player_two_move = player_two.make_move(board.board_display)
    board.place_here(player_two_move, player_two.piece)
    if game.in_a_row?(player_two.placed_pieces, player_two.name)
        break
    end 
end

game.declare_winner