module Web::Controllers::Games
  class Create
    include Web::Action

    def call(params)
      game = GameRepository.persist(Game.new(player_count: 2))
      redirect_to routes.game_path(game.id)
    end
  end
end
