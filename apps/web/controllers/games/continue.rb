module Web::Controllers::Games
  class Continue
    include Web::Action

    def call(params)
      game = GameRepository.find(params[:id])
      game.continue!
      GameRepository.persist(game)

      redirect_to routes.game_path(game.id)
    end
  end
end