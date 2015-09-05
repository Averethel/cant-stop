namespace 'api' do
  get 'games', to: 'api_games#index'
  get 'games/:id', to: 'api_games#show'
end

resources :games

# Configure your routes here
# See: http://www.rubydoc.info/gems/lotus-router/#Usage
