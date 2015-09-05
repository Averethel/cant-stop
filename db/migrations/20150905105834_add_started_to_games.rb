Lotus::Model.migration do
  change do
    add_column :games, :started, :boolean, default: false
  end
end
