module Web::Controllers::ApiGames
  class Move
    include Web::Action
    expose :game

    def call(params)
      @game = GameRepository.find(params[:id])
      begin
        @game.move(data['rolls'])
        GameRepository.persist(@game)
      rescue Exceptions::InvalidRolls
        status 400, "Invalid rolls selected"
      end
    end

  private

    def data
      @data ||= JSON.parse(request.body.read).tap do |data|
        data['rolls'] ||= []
      end
    end
  end
end
