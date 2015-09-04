require 'json'

class Game
  include Lotus::Entity

  ROW_LENGTHS =  [3, 5, 7, 9, 11, 13, 11, 9, 7, 5, 3]

  attributes :current_runners, :current_roll, :player_positions

  def initialize(attributes)
    player_count = attributes[:player_count] || 0

    @current_roll          = roll_dice.join(',')
    self.runner_positions  = Array.new(11, 0)
    self.current_positions = {}.tap do |player_positions|
      player_count.times do |i|
        player_positions[i+1] = Array.new(11, 0)
      end
    end
    super
  end

  def runner_positions
    @current_runners.split(',').map(&:to_i)
  end

  def runner_positions=(positions)
    @current_runners = positions.join(',')
  end

  def current_positions
    JSON.parse(@player_positions)
  end

  def current_positions=(positions)
    @player_positions = positions.to_json
  end

  def current_dice_roll
    @current_roll.split(',').map(&:to_i)
  end

  def roll_dice!
    roll = roll_dice
    @current_roll = roll.join(',')
    GameRepository.persist(self)
    roll
  end

  def can_move?
    possible_rolls.any?{ |r| can_progress_or_add_runner?(r) }
  end

private

  def can_progress_or_add_runner?(rool)
    can_place_runner?(roll) &&
    (has_runner?(roll) || runner_count < 3)
  end

  def has_runner(roll)
    index = roll_to_index(roll)

    runner_positions[index] > 0
  end


  def possible_rolls
    current_dice_roll.combination(2).map{ |a, b| a + b }.uniq
  end

  def runner_count
    runner_positions.find_all{ |p| p > 0 }.count
  end

  def can_place_runner?(roll)
    !runner_on_top?(roll) &&
    !controlled?(roll)
  end

  def runner_on_top?(roll)
    index = roll_to_index(roll)

    controls?(index, runner_positions)
  end

  def controlled?(roll)
    index = roll_to_index(roll)

    current_positions.any?{ |_, v| controls(index, v) }
  end

  def controls?(index, list)
    ROW_LENGTHS[index] == list[index]
  end

  def roll_to_index(roll)
    roll - 2
  end

  def roll_dice
    Array.new(4){ rand(6) + 1}
  end
end
