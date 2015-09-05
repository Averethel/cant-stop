module Web::Controllers::ApiGames
  class Continue
    include Web::Action
    expose :roll

    def call(params)
      game = GameRepository.find(params[:id])
      @roll = game.continue!
      GameRepository.persist(game)
    end
  end
end
