module Web::Views::ApiGames
  class FailMove
    include Web::View
    format :json

    def render
      _raw Serializers::Games::Show.new(game).serialize.to_json
    end
  end
end