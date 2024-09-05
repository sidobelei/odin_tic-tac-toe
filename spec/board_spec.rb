require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  let(:coordinates) { [2, 1]}
  let(:piece) { 'x' }
  let(:old_array) { [            
    [" _________________"],
    ["|     |     |     |"],
    ["|  ", "1", "  |  " , "2" , "  |  ", "3", "  |"],
    ["|_____|_____|_____|"],
    ["|     |     |     |"],
    ["|  ", "4", "  |  " , "5" , "  |  ", "6", "  |"],
    ["|_____|_____|_____|"],
    ["|     |     |     |"],
    ["|  ", "7", "  |  " , "8" , "  |  ", "9", "  |"],
    ["|_____|_____|_____|"]
  ] }
  let(:new_array) { [            
    [" _________________"],
    ["|     |     |     |"],
    ["|  ", "x", "  |  " , "2" , "  |  ", "3", "  |"],
    ["|_____|_____|_____|"],
    ["|     |     |     |"],
    ["|  ", "4", "  |  " , "5" , "  |  ", "6", "  |"],
    ["|_____|_____|_____|"],
    ["|     |     |     |"],
    ["|  ", "7", "  |  " , "8" , "  |  ", "9", "  |"],
    ["|_____|_____|_____|"]
  ] }

  describe '#place_here' do
    before do 
      allow(board).to receive(:display_board)
    end
      context 'when given verified coordinates and a game piece' do
      it 'assigns a game piece at the given coordinates' do
        expect{ board.place_here(coordinates, piece) }.to change {board.board_display}.from(old_array).to(new_array)
      end

      it 'makes a call to #display_board' do
         expect(board).to receive(:display_board)
         board.place_here(coordinates, piece)
      end
    end
  end
end