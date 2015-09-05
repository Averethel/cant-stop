require_relative '../base'

module Serializers::Games
  class Index < Serializers::Base
    def initialize(game)
      @game = game
    end

    def serialize
      {id:@game.id}
    end
  end
end
