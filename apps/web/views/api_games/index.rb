require_relative '../../../../lib/cant-stop/serializers/games/index.rb'
module Web::Views::ApiGames
  class Index
    include Web::View
    format :json

    def render
      games.map{|g| Serializers::Games::Index.new(g).serialize}.to_json
    end

  end
end
