class RandomAi
  attr_reader :game, :player

  def initialize(game, player = 1)
    @game = game
    @player = player
  end

  def run
    game.start! unless game.started?

    until game.game_over?
      do_game_move
    end

    puts "Game over, player #{game.winner} won."
  end

  def do_turn
    if game.current_player.to_i == player
      puts "Doing AI turn"
    end

    while game.current_player.to_i == player
      do_game_move
    end
  end

  private

  def do_game_move
    if game.move_state?
      if game.can_move?
        random_move
      else
        puts "Can't move, failing move."
        game.fail_move!
      end
    else
      continue_or_stop_turn
    end
  end

  def random_move
    random_choice = game.current_dice_sums.sample
    puts "Choosing #{random_choice.inspect}"

    begin
      game.move(random_choice)
    rescue Exceptions::InvalidRolls => e
      puts "Invalid choice!"
    end
  end

  def continue_or_stop_turn
    continue = [true, false].sample

    if continue
      puts 'Continuing turn'
      game.continue!
    else
      puts 'Stopping turn'
      game.stop!
    end
  end
end
