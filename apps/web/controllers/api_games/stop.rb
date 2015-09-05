module Web::Controllers::ApiGames
  class Stop
    include Web::Action
    expose :game

    def call(params)
      @game = GameRepository.find(params[:id])
      begin
        @game.stop!
        GameRepository.persist(@game)
      rescue Exceptions::CantStop
        status 400, "Make a move first"
      end
    end
  end
end
