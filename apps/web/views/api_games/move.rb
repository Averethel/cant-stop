module Web::Views::ApiGames
  class Move
    include Web::View
    format :json

    def render
      _raw runners.to_json
    end
  end
end
