module Web::Controllers::Games
  class Create
    include Web::Action

    def call(params)
      g = Game.new({player_count: 2, ai_type: params['game']['ai_type']})
      game = GameRepository.persist(g)
      redirect_to routes.game_path(game.id)
    end
  end
end
