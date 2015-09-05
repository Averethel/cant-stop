namespace 'api' do
  resources :games, only: [:index, :show], controller: :api_games do
    member do
      post :continue
      post :stop
      post :move
      post :fail_move
    end
  end
end

post '/games/:id/start', to: 'games#start', as: :start_game
post '/games/:id/continue', to: 'games#continue', as: :continue_game
post '/games/:id/stop', to: 'games#stop', as: :stop_game
post '/games/:id/move', to: 'games#move', as: :move_game
post '/games/:id/fail_move', to: 'games#fail_move', as: :fail_move_game

resources :games

# Configure your routes here
# See: http://www.rubydoc.info/gems/lotus-router/#Usage
