require_relative '../serializers'

module Serializers::Games
  class Index
    def initialize(game)
      @game = game
    end

    def serialize
      {id:@game.id}
    end

    def self.serialize_collection(collection)
      collection.map{ |e| new(e).serialize }
    end
  end
end
