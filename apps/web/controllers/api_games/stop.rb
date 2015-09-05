module Web::Controllers::ApiGames
  class Stop
    include Web::Action
    expose :progress
    expose :player

    def call(params)
      game = GameRepository.find(params[:id])
      begin
        @player = game.current_player
        @progress = game.stop!
        GameRepository.persist(game)
      rescue Exceptions::CantStop
        status 400, "Make a move first"
      end
    end
  end
end
