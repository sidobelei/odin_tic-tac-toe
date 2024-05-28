class Board
    attr_reader 
    def initialize
        @board_display = [
            ["|  ", "1", "|  ", "2", "|  ", "3", "  |"], 
            ["|  ", "4", "|  ", "5", "|  ", "6", "  |"], 
            ["|  ", "7", "|  ", "8", "|  ", "9", "  |"]
        ]
        @game_over = false
        @winner = "tie"
    end
end