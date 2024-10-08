require_relative './board'
require_relative './player'

class Game 
    attr_reader :game_over, :winner, :player_one, :player_two, :board

    WINNING_COMBO = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["1", "4", "7"],
        ["2", "5", "8"],
        ["3", "6", "9"],
        ["1", "5", "9"],
        ["3", "5", "7"]
    ]
    
    ALLOWED_PIECES = 9

    def initialize
        puts "Welcome to Tic Tac Toe!\n\n"
        print "Player One Name: "
        player_one_name = gets.chomp
        puts "\n" 
        print "Player Two Name: "
        player_two_name = gets.chomp
        puts "\n" 
        @game_over = false
        @winner = nil
        @player_one = Player.new(player_one_name, 'X')
        @player_two = Player.new(player_two_name, 'O')
        @board = Board.new
    end

    def play_game
        @board.display_board
        until game_over
            player_one_move = @player_one.make_move(@board.board_display)
            @board.place_here(player_one_move, @player_one.piece)
            if in_a_row?(@player_one.placed_pieces, @player_one.name)
                break
            elsif full_board?(@player_one.placed_pieces, @player_two.placed_pieces)
                break
            end
            player_two_move = @player_two.make_move(@board.board_display)
            @board.place_here(player_two_move, @player_two.piece)
            if in_a_row?(@player_two.placed_pieces, @player_two.name)
                break
            end 
        end
        declare_winner
    end
    
    def in_a_row?(placed_pieces, name)
        WINNING_COMBO.each do |element|
            if (element - placed_pieces).empty?
                @game_over = true
                @winner = name
                break
            end
        end
        return game_over
    end
    
    def full_board?(player_one_pieces, player_two_pieces)
        if (player_one_pieces + player_two_pieces).length >= ALLOWED_PIECES
            @game_over = true
        end
        return @game_over
    end

    def declare_winner
        if winner
            puts "#{winner} Wins!"
        else
            puts "It's a tie!"
        end
    end
end