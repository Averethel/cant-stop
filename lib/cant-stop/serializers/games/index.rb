require_relative '../serializers'

module Serializers::Games
  class Index
    def initialize(game)
      @game = game
    end

    def serialize
      {id:@game.id}
    end
  end
end
