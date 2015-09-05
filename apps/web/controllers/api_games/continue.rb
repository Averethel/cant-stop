module Web::Controllers::ApiGames
  class Continue
    include Web::Action
    expose :roll

    def call(params)
      game = GameRepository.find(params[:id])
      begin
        game.continue!
        @roll = game.current_dice_pairs_with_validity
        GameRepository.persist(game)
      rescue Exceptions::CantContinue
        status 400, "Make a move first"
      end
    end
  end
end
