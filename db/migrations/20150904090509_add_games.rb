Lotus::Model.migration do
  change do
    create_table :games do
      primary_key :id
      column :current_runners, String
      column :player_positions, String
    end
  end
end
