require 'spec_helper'

RSpec.describe Game do
  subject { Game.new({}) }

  context 'new Game' do
    it 'can move' do
      expect(subject.can_move?).to be true
    end
  end

  context 'game in progress' do
    before do
      allow(subject).to receive(:current_dice_roll).and_return(dice_roll)
      allow(subject).to receive(:runner_positions).and_return(runner_positions)
    end

    context 'can only place runner on 2' do
      let(:dice_roll) { [1, 1, 1, 1] }

      context 'all runners placed' do
        let(:runner_positions) { [0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0] }

        it 'cannot move' do
          expect(subject.can_move?).to be false
        end
      end

      context 'not all runners placed' do
        let(:runner_positions) { [0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0] }

        it 'can move' do
          expect(subject.can_move?).to be true
        end
      end

      context 'runner in row 2 on top position' do
        let(:runner_positions) { [3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }

        it 'cannot move because the only progressable runner is on top' do
          expect(subject.can_move?).to be false
        end
      end

      context 'runner in row 2 not in top position' do
        let(:runner_positions) { [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }

        it 'can move' do
          expect(subject.can_move?).to be true
        end
      end

      context do
        let(:runner_positions) { [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
        let(:current_positions) { { 1 => [3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] } }

        before do
          allow(subject).to receive(:current_positions).and_return(current_positions)
        end

        it 'cannot move because the only available row is taken' do
          expect(subject.can_move?).to be false
        end
      end
    end

  end

end
