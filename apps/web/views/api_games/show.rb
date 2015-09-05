require_relative '../../../../lib/cant-stop/serializers/games/show'

module Web::Views::ApiGames
  class Show
    include Web::View
    format :json

    def render
      Serializers::Games::Show.new(game).serialize.to_json
    end
  end
end
