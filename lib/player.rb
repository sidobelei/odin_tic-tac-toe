class Player
    attr_reader :piece
    def initialize (piece)
        @piece = piece 
        @placed_pieces = []
    end

    def make_move(board)
        valid_move = false
        coordinates = [nil, nil]
        while valid_move == false
            print "#{} your turn: "
            placement = gets.chomp
            next unless ["1", "2", "3", "4", "5", "6", "7", "8", "9"].include?(placement)
            board.each_with_index do |row, index|
                if row.find_index(placement) != nil
                    coordinates[1] = row.find_index(placement)
                    coordinates[0] = index
                    valid_move = true
                    break
                end
            end
        end
        @placed_pieces.push(placement)
        return coordinates
    end
end