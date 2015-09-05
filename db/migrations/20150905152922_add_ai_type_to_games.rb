Lotus::Model.migration do
  change do
    add_column :games, :ai_type, String, default: nil
  end
end
