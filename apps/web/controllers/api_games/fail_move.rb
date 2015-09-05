module Web::Controllers::ApiGames
  class FailMove
    include Web::Action
    expose :game

    def call(params)
      @game = GameRepository.find(params[:id])
      begin
        @game.fail_move!
        GameRepository.persist(@game)
      rescue Exceptions::CanMove
        status 400, "You can make a move"
      end
    end
  end
end
