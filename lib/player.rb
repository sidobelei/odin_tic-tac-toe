class Player
    def initialize (piece)
        @piece = piece 
        @placed_pieces = Array.new(8, nil)
    end
end