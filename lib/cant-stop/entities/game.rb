require 'json'
require_relative '../exceptions/invalid_rolls'
require_relative '../exceptions/cant_stop'
require_relative '../exceptions/cant_continue'

class Game
  include Lotus::Entity

  ROW_LENGTHS =  [3, 5, 7, 9, 11, 13, 11, 9, 7, 5, 3]

  attributes :current_runners, :current_roll, :player_positions, :current_player, :started

  def initialize(attributes)
    player_count = attributes[:player_count] || 2

    self.runner_positions  = Array.new(11, 0)
    self.current_positions = {}.tap do |player_positions|
      player_count.times do |i|
        player_positions[i] = Array.new(11, 0)
      end
    end
    self.current_player = 0
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
    return [] if @current_roll.nil?
    @current_roll.split(',').map(&:to_i)
  end

  def roll_dice!
    roll = roll_dice
    @current_roll = roll.join(',')
    roll
  end

  def continue!
    raise Exceptions::CantContinue unless current_dice_roll.empty?

    roll_dice!
  end

  def started?
    started
  end

  def start!
    self.started = true
    roll_dice!
  end

  def stop!
    raise Exceptions::CantStop unless current_dice_roll.empty?
    progress = save_progress
    reset_runners
    next_player
    roll_dice!

    progress
  end

  def can_move?
    possible_rolls.any?{ |r| can_progress_or_add_runner?(r) }
  end

  def move(rolls)
    raise Exceptions::InvalidRolls unless valid_rolls?(rolls)
    rolls.each do |roll|
      progress(roll)
    end

    reset_roll

    self.runner_positions
  end

  def move_state?
    !current_dice_roll.empty?
  end

  def game_over?
    winner != nil
  end

  def winner
    current_positions.values.map { |positions| finished_rows(positions) }.map(&:size).index(3)
  end

  def current_dice_sums
    return [] if current_dice_roll.empty?

    [
      [current_dice_roll[0] + current_dice_roll[1], current_dice_roll[2] + current_dice_roll[3]].sort,
      [current_dice_roll[1] + current_dice_roll[2], current_dice_roll[0] + current_dice_roll[3]].sort,
      [current_dice_roll[0] + current_dice_roll[2], current_dice_roll[1] + current_dice_roll[3]].sort
    ]
  end

  private

  def reset_roll
    @current_roll = ""
  end

  def finished_rows(positions)
    [].tap do |row_indices|
      positions.each_with_index do |position, index|
        if position == ROW_LENGTHS[index]
          row_indices << index
        end
      end
    end
  end

  def save_progress
    positions = current_positions
    positions[current_player.to_s] = merge_with_runners(positions[current_player.to_s])
    self.current_positions = positions

    positions[current_player.to_s]
  end

  def merge_with_runners(positions)
    positions.zip(runner_positions).map(&:max)
  end

  def reset_runners
    self.runner_positions = Array.new(11, 0)
  end

  def next_player
    self.current_player += 1
    self.current_player %= player_count
  end

  def progress(roll)
    return move_runner(roll) if has_runner?(roll)
    add_runner(roll) if runner_count < 3
  end

  def add_runner(roll)
    index = roll_to_index(roll)
    positions = runner_positions
    positions[index] = current_positions[current_player.to_s][index] + 1
    self.runner_positions = positions
  end

  def move_runner(roll)
    positions = runner_positions
    positions[roll_to_index(roll)] += 1 unless runner_on_top?(roll)
    self.runner_positions = positions
  end

  def valid_rolls?(rolls)
    current_dice_sums.include?(rolls.sort)
  end

  def can_progress_or_add_runner?(roll)
    can_place_runner?(roll) &&
    (has_runner?(roll) || runner_count < 3)
  end

  def has_runner?(roll)
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

    current_positions.any?{ |_, v| controls?(index, v) }
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

  def player_count
    current_positions.keys.size
  end
end
