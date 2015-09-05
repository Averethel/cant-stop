namespace 'api' do
  get 'games', to: 'api_games#index'
  get 'games/:id', to: 'api_games#show'
end

post '/games/:id/continue', to: 'games#continue', as: :continue_game
post '/games/:id/stop', to: 'games#stop', as: :stop_game

resources :games

# Configure your routes here
# See: http://www.rubydoc.info/gems/lotus-router/#Usage
