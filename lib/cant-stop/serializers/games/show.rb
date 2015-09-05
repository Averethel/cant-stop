require_relative '../base'

module Serializers::Games
  class Show < Serializers::Base
    def initialize(game)
      @game = game
    end

    def serialize
      {
        id: @game.id,
        runner_positions: @game.runner_positions,
        player_positions: @game.current_positions,
        dice_roll: @game.current_dice_roll,
        dice_pairs: @game.current_dice_pairs_with_validity,
        current_player: @game.current_player,
        game_over: @game.game_over?,
        winner: @game.winner
      }
    end
  end
end
