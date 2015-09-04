require 'spec_helper'

RSpec.describe Game do
  subject { described_class.new({}) }

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
        let(:current_positions) { { "0" => [3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] } }

        before do
          allow(subject).to receive(:current_positions).and_return(current_positions)
        end

        it 'cannot move because the only available row is taken' do
          expect(subject.can_move?).to be false
        end
      end
    end

  end

  context 'sending rolls back' do
    before do
      allow(subject).to receive(:current_dice_roll).and_return(dice_roll)
    end

    context '.valid_rolls' do
      let(:dice_roll) { [1, 2, 3, 4] }
      it 'rejects invalid rolls' do
        expect(subject.send(:valid_rolls?, [2, 2])).to be false
      end
      it 'allows valid rolls that are unsorted' do
        expect(subject.send(:valid_rolls?, [7, 3])).to be true
      end
    end
    context 'allows duplicated dices in roll' do
      let(:dice_roll) {[1, 2, 2, 3]}
      it 'are handled properly' do
        expect(subject.send(:valid_rolls?, [3, 5])).to be true
      end
    end
  end

  context '.move' do
    before do
      allow(subject).to receive(:current_dice_roll).and_return(dice_roll)
    end

    context 'empty board' do
      let(:dice_roll) {[5, 3, 2, 2]}
      it 'add runners on dices 8 and 4 ' do
        expect(subject.move([8, 4])).to eq [0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0]
      end
    end

    context 'board in play' do
      let(:dice_roll) {[5, 3, 2, 2]}
      let(:current_positions) { { "0" => [0, 0, 2, 0, 4, 0, 0, 0, 0, 0, 0] } }

      before do
        allow(subject).to receive(:current_positions).and_return(current_positions)
      end

      it 'moves dice 4 forward and adds dice 8 runner' do
        expect(subject.move([8, 4])).to eq [0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0]
      end
    end

    context 'board in play with active moves' do
      let(:dice_roll) {[5, 3, 2, 2]}
      let(:current_positions) { { "0" => [0, 0, 2, 0, 4, 0, 0, 0, 0, 0, 0] } }

      before do
        allow(subject).to receive(:current_positions).and_return(current_positions)
        subject.runner_positions = [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
      end

      it 'moves dice 4 and 8 forward' do
        expect(subject.move([8, 4])).to eq [0, 0, 3, 0, 0, 0, 2, 0, 0, 0, 0]
      end
    end

    context 'board with 2 runners' do
      let(:dice_roll) {[1, 1, 2, 2]}

      before do
        subject.runner_positions = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1]
      end

      it 'adds runner to 2 on order 2, 4' do
        expect(subject.move([2,4])).to eq([1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1])
      end

      it 'adds runner to 4 on order 4, 2' do
        expect(subject.move([4,2])).to eq([0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1])
      end
    end
  end

  context '.stop!' do
    let(:new_roll){ [1,2,3,4] }
    let(:current_positions){{
      "0" => [0, 0, 2, 0, 4, 0, 0, 0, 0, 0, 0],
      "1" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    }}
    let(:updated_positions){ [1, 0, 3, 0, 4, 0, 0, 0, 0, 1, 0] }

    before do
      subject.current_roll = "1,1,2,2"
      subject.runner_positions = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
      subject.current_positions = current_positions
      subject.move([2, 4])
      allow(subject).to receive(:roll_dice).and_return(new_roll)
    end

    it 'saves the progress' do
      expect{
        subject.stop!
      }.to change{
        subject.current_positions["0"]
      }.to(updated_positions)
    end

    it 'resets the runners' do
      expect{
        subject.stop!
      }.to change{
        subject.runner_positions
      }.to(Array.new(11,0))
    end

    context 'moving to the next player' do
      context 'when current player is not the last one' do
        before do
          subject.current_player = 0
        end

        it 'moves to next player' do
          expect{
            subject.stop!
          }.to change{
            subject.current_player
          }.to(1)
        end
      end

      context 'when current player is the last one' do
        before do
          subject.current_player = 1
        end

        it 'goes back to first player' do
          expect{
            subject.stop!
          }.to change{
            subject.current_player
          }.to(0)
        end
      end
    end

    it 'rolls again' do
      expect{
        subject.stop!
      }.to change{
        subject.current_dice_roll
      }.to(new_roll)
    end

    it 'returns updated_positions' do
      expect(subject.stop!).to eq(updated_positions)
    end
  end

  context '.continue!' do
    let(:new_roll){ [1,2,3,4] }

    before do
      subject.current_roll = "1,1,1,1"
      allow(subject).to receive(:roll_dice).and_return(new_roll)
    end

    it 'rolls again' do
      expect{
        subject.continue!
      }.to change{
        subject.current_dice_roll
      }.to(new_roll)
    end

    it 'returns the roll back' do
      expect(subject.continue!).to eq(new_roll)
    end
  end
end
