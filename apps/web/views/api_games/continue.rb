module Web::Views::ApiGames
  class Continue
    include Web::View
    format :json

    def render
      _raw roll.to_json
    end
  end
end
