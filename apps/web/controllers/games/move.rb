module Web::Controllers::Games
  class Move
    include Web::Action

    def call(params)
      game = GameRepository.find(params[:id])

      begin
        game.move(params['game']['sums'].split(',').map(&:to_i))
        GameRepository.persist(game)
      rescue Exceptions::InvalidRolls
        
      end

      redirect_to routes.game_path(game.id)
    end
  end
end
