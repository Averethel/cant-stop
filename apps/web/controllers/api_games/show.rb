module Web::Controllers::ApiGames
  class Show
    include Web::Action
    expose :game

    def call(params)
      @game = GameRepository.find(params[:id])
    end
  end
end
