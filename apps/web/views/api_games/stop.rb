module Web::Views::ApiGames
  class Stop
    include Web::View
    format :json

    def render
      _raw progress.to_json
    end
  end
end
