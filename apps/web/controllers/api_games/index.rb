module Web::Controllers::ApiGames
  class Index
    include Web::Action
    expose :games
    
    def call(params)
      @games = GameRepository.all
    end
  end
end
