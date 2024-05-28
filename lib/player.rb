class Player
    def initialize (piece)
        @piece = piece 
        @placed_pieces = []
    end

    def make_move
        print "#{} your turn: "
        placement = gets.chomp
        @placed_pieces.push(placement)
        return placement
    end
end