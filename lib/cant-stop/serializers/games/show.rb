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
        current_player: @game.current_player
      }
    end
  end
end
