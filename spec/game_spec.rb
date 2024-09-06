require_relative '../lib/game'

describe Game do
  subject(:game) {described_class.new}

  describe '#in_a_row?' do
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
end