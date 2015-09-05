module Web::Controllers::Games
  class Show
    include Web::Action
    expose :game

    def call(params)
      @game = GameRepository.find(params[:id])
    end
  end
end
