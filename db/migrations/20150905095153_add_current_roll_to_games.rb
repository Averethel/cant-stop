Lotus::Model.migration do
  change do
    add_column :games, :current_roll, String
  end
end
