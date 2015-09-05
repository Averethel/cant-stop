module Web::Controllers::Games
  class Stop
    include Web::Action

    def call(params)
      game = GameRepository.find(params[:id])
      game.stop!
      GameRepository.persist(game)

      redirect_to routes.game_path(game.id)
    end
  end
end
