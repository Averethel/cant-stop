module Web::Controllers::Games
  class FailMove
    include Web::Action

    def call(params)
      game = GameRepository.find(params[:id])
      game.fail_move!
      GameRepository.persist(game)

      redirect_to routes.game_path(game.id)
    end
  end
end
