class Game 
    attr_reader :game_over, :winner

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
        @game_over = false
        @winner = nil
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