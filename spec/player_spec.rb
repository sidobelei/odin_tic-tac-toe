require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('Luffy', 'X') }

  before do
    allow(player).to receive(:print)
  end

  describe '#make_move' do
    let(:empty_board) { [
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
    let(:incomplete_board) { [
      [" _________________"],
      ["|     |     |     |"],
      ["|  ", "X", "  |  " , "O" , "  |  ", "3", "  |"],
      ["|_____|_____|_____|"],
      ["|     |     |     |"],
      ["|  ", "4", "  |  " , "X" , "  |  ", "6", "  |"],
      ["|_____|_____|_____|"],
      ["|     |     |     |"],
      ["|  ", "7", "  |  " , "8" , "  |  ", "O", "  |"],
      ["|_____|_____|_____|"]
    ] }
    
    context 'when you make a valid move' do
      before do
        allow(player).to receive(:gets).and_return('7')
      end

      context 'when the board is empty' do
        it 'adds another element to placed_pieces' do
          expect { player.make_move(empty_board) }.to change { player.placed_pieces.length }.by(1)  
        end

        it 'returns coordinates of the game piece on the board' do
          coordinates = player.make_move(empty_board)
          expect(coordinates).to eq([8, 1])
        end
      end

      context 'when the board is partially full' do
        it 'adds another element to placed_pieces' do
          expect { player.make_move(incomplete_board) }.to change { player.placed_pieces.length }.by(1)  
        end

        it 'returns coordinates of the game piece on the board' do
          coordinates = player.make_move(incomplete_board)
          expect(coordinates).to eq([8, 1])
        end
      end
    end

    context 'when you make an invalid move' do
      context 'when you make an invalid input once and then a valid move' do
        before do
          allow(player).to receive(:gets).and_return('10', '6')
        end

        it 'calls for player input twice' do  
          expect(player).to receive(:gets).twice
          player.make_move(empty_board)
        end

        it 'adds one element to placed_pieces' do
          expect { player.make_move(empty_board) }.to change { player.placed_pieces.length }.by(1)  
        end

        it 'returns the valid coordinates of the game piece on the board' do
          coordinates = player.make_move(empty_board)
          expect(coordinates).to eq([5, 5])
        end
      end

      context 'when you make an invalid input 9 times and then a valid move' do
        before do
          allow(player).to receive(:gets).and_return(
            '10', 
            '1100',
            'ajdkf',
            'aewr',
            '544',
            '23284',
            'aija!ejwrk',
            'oae',
            '93dsf',
            '8'
            )
        end
        it 'calls for player input ten times' do  
          expect(player).to receive(:gets).exactly(10).times
          player.make_move(empty_board)
        end

        it 'adds one element to placed_pieces' do
          expect { player.make_move(empty_board) }.to change { player.placed_pieces.length }.by(1)  
        end

        it 'returns the valid coordinates of the game piece on the board' do
          coordinates = player.make_move(empty_board)
          expect(coordinates).to eq([8, 3])
        end
      end
      
      context 'when you try to place a piece on an occupied space and then an unoccupied space' do
        before do
          allow(player).to receive(:gets).and_return('1', '3')
        end

        it 'calls for player input twice' do  
          expect(player).to receive(:gets).twice
          player.make_move(incomplete_board)
        end

        it 'adds one element to placed_pieces' do
          expect { player.make_move(incomplete_board) }.to change { player.placed_pieces.length }.by(1)  
        end

        it 'returns the valid coordinates of the game piece on the board' do
          coordinates = player.make_move(incomplete_board)
          expect(coordinates).to eq([2, 5])
        end
      end
    end
  end
end