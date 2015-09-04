module Web::Controllers::Games
  class Create
    include Web::Action

    def call(params)
      GameRepository.persist(Game.new(player_count: 2))
      redirect_to routes.games_path
    end
  end
end
