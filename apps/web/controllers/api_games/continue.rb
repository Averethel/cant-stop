module Web::Controllers::ApiGames
  class Continue
    include Web::Action
    expose :game

    def call(params)
      @game = GameRepository.find(params[:id])
      begin
        @game.continue!
        GameRepository.persist(@game)
      rescue Exceptions::CantContinue
        status 400, "Make a move first"
      end
    end
  end
end
