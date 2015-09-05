module Web::Views::ApiGames
  class Stop
    include Web::View
    format :json

    def render
      _raw {
        player_positions: progress,
        player: player
      }.to_json,
    end
  end
end
