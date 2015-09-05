module Web::Views::Games
  class Show
    include Web::View

    def player_classes(column_index, row_index)
      classes = []

      game.current_positions.each do |player, positions|
        column_position = positions[column_index]
        if column_position > 0 && column_position == row_index
          classes << "player-#{player}"
        end
      end

      classes.join ' '
    end

    def runner_class(column_index, row_index)
      runner_position = game.runner_positions[column_index]
      if runner_position > 0 && row_index == runner_position
        'runner'
      else
        ''
      end
    end
  end
end
