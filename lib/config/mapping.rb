collection :games do
  entity     Game
  repository GameRepository

  attribute :id, Integer
  attribute :current_runners, String
  attribute :player_positions, String
end
