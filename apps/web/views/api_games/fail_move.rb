module Web::Views::ApiGames
  class FailMove
    include Web::View
    format :json

    def render
      _raw roll.to_json
    end
  end
end
