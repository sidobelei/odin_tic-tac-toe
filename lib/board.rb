class Board
    attr_reader :board_display
    def initialize
        @board_display = [
            ["|  ", "1", "  |  ", "2", "  |  ", "3", "  |"], 
            ["|  ", "4", "  |  ", "5", "  |  ", "6", "  |"], 
            ["|  ", "7", "  |  ", "8", "  |  ", "9", "  |"]
        ]
    end

    def place_here(coordinates, piece)
        row = coordinates[0]
        column = coordinates[1]
        board_display[row][column] = piece
        display_board
    end

    def display_board
        puts "\n" 
        board_display.each do |row| 
            row.each do |element| 
                print element
            end
            print "\n"
        end
        puts "\n" 
    end
end