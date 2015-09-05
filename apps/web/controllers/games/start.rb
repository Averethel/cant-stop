module Web::Controllers::Games
  class Start
    include Web::Action

    def call(params)
      game = GameRepository.find(params[:id])
      game.start!
      GameRepository.persist(game)

      redirect_to routes.game_path(game.id)
    end
  end
end
