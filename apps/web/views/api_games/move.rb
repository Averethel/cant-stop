module Web::Views::ApiGames
  class Move
    include Web::View
    format :json

    def render
      _raw({ runner_positions: runners }.to_json)
    end
  end
end
