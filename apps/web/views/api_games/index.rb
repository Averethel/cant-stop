require_relative '../../../../lib/cant-stop/serializers/games/index'
module Web::Views::ApiGames
  class Index
    include Web::View
    format :json

    def render
      _raw Serializers::Games::Index.serialize_collection(games).to_json
    end
  end
end