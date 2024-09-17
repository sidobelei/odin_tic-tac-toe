require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    subject(:game) {described_class.new}

    before do
      allow(game).to receive(:gets).and_return("Player 1", "Player 2")
    end

    context 'when a new Game object is created' do 
      it 'creates a Player object for player_one' do
        expect(game.player_one).to be_a(Player)
      end

      it 'creates a Player object for player_two' do
        expect(game.player_two).to be_a(Player)
      end

      it 'a Board object is created' do
        expect(game.board).to be_a(Board)
      end

    end
  end


  describe '#play_game' do
    subject(:p1_game_won) { described_class.new }
    let(:player1) { double('Player', name: 'Player 1', piece: 'X', placed_pieces: ['1', '4', '7']) }
    let(:player2) { double('Player', name: 'Player 2', piece: 'O', placed_pieces: ['3', '9']) }

    before do
      allow(p1_game_won.board).to receive(:display_board)
    end

    context 'when player one wins' do
      it 'prints "Player 1 Wins!"' do
        p1_game_won.instance_variable_set(:@player_one, player1)
        p1_game_won.instance_variable_set(:@player_two, player2)
        p1_game_won.instance_variable_set(:@game_over, true)
        p1_game_won.instance_variable_set(:@winner, 'Player 1')
        expect { p1_game_won.play_game }.to output("Player 1 Wins!\n").to_stdout  
      end
    end

    subject(:p2_game_won) { described_class.new }
    let(:player1) { double('Player', name: 'Player 1', piece: 'X', placed_pieces: ['1', '7']) }
    let(:player2) { double('Player', name: 'Player 2', piece: 'O', placed_pieces: ['3', '6', '9']) }
    
    before do
      allow(p2_game_won.board).to receive(:display_board)
    end

    context 'when player two wins' do
      it 'prints "Player 2 Wins!' do
        p2_game_won.instance_variable_set(:@player_one, player1)
        p2_game_won.instance_variable_set(:@player_two, player2)
        p2_game_won.instance_variable_set(:@game_over, true)
        p2_game_won.instance_variable_set(:@winner, 'Player 2')
        expect { p2_game_won.play_game }.to output("Player 2 Wins!\n").to_stdout
      end
    end

    subject(:tie_game) { described_class.new }
    let(:player1) { double('Player', name: 'Player 1', piece: 'X', placed_pieces: ['1', '2', '5', '6', '7']) }
    let(:player2) { double('Player', name: 'Player 2', piece: 'O', placed_pieces: ['3', '4', '8', '9']) }
    
    before do
      allow(tie_game.board).to receive(:display_board)
    end

    context 'when no one wins' do
      it 'prints "It\'s a tie!"' do
        tie_game.instance_variable_set(:@player_one, player1)
        tie_game.instance_variable_set(:@player_two, player2)
        tie_game.instance_variable_set(:@game_over, true)
        tie_game.instance_variable_set(:@winner, nil)
        expect { tie_game.play_game }.to output("It\'s a tie!\n").to_stdout
      end
    end
  end

  describe '#in_a_row?' do
  subject(:game) {described_class.new}
    let(:winning_combo) { ['1', '5', '9'] }
    let(:losing_combo) { ['3', '6', '8'] }
    let(:name) { 'Luffy' }

    context 'when there is three in a row' do
      it 'game_over changes to true' do
        expect{ game.in_a_row?(winning_combo, name) }.to change{ game.game_over }.from(false).to(true)
      end

      it 'the name of the current player is assigned to winner' do
        expect { game.in_a_row?(winning_combo, name) }.to change { game.winner }.from(nil).to(name)
      end

      it 'returns game_over as true' do
        game_over = game.in_a_row?(winning_combo, name)
        expect(game_over).to be(true)
      end
    end

    context "when there isn't three in a row" do
      it 'game_over stays false' do
          expect { game.in_a_row?(losing_combo, name) }.not_to change { game.game_over }
      end

      it 'winner remains nil' do
        expect { game.in_a_row?(losing_combo, name) }.not_to change { game.winner }
      end

      it 'returns game_over as false' do
        game_over = game.in_a_row?(losing_combo, name)
        expect(game_over).to be(false)
      end
    end
  end

  describe '#full_board?' do
  subject(:game) {described_class.new}
    let(:p1_positions) { ['1', '2', '5', '6', '7'] }
    let(:p1_positions_incomplete) { ['1', '2', '5', '6'] }
    let(:p2_positions) { ['3', '4', '8', '9'] }
    
    context 'when the board is full' do
      it 'game_over changes to true' do
        expect { game.full_board?(p1_positions, p2_positions) }.to change {game.game_over}.from(false).to(true)
      end

      it 'returns game_over as true' do 
        game_over = game.full_board?(p1_positions, p2_positions)
        expect(game_over).to be(true)
      end
    end

    context 'when the board is not full' do
      it 'game_over stays false' do
        expect { game.full_board?(p1_positions_incomplete, p2_positions) }.not_to change {game.game_over}
      end

      it 'returns game_over as false' do
        game_over = game.full_board?(p1_positions_incomplete, p2_positions)
        expect(game_over).to be(false)
      end
    end
  end
end