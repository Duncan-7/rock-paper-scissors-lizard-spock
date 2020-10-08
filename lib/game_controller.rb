require_relative "player"

class GameController
  attr_reader :player1, :player2, :winning_score, :win_conditions

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @win_conditions = generate_win_conditions
    @winning_score = get_winning_score
    @game_over = false
    game_loop
  end

  def generate_win_conditions
    win_conditions = [
      {selections: ["rock", "paper"], winner: "paper"},
      {selections: ["rock", "scissors"], winner: "rock"},
      {selections: ["rock", "lizard"], winner: "rock"},
      {selections: ["rock", "spock"], winner: "spock"},
      {selections: ["paper", "scissors"], winner: "scissors"},
      {selections: ["paper", "lizard"], winner: "lizard"},
      {selections: ["paper", "spock"], winner: "paper"},
      {selections: ["scissors", "lizard"], winner: "scissors"},
      {selections: ["scissors", "spock"], winner: "spock"},
      {selections: ["lizard", "spock"], winner: "lizard"},
    ]
  end

  def get_winning_score
    puts "How many rounds needed to win:"
    number = gets.chomp.to_i
  end

  def get_selections
    current_player = @player1
    puts "Each player must enter rock, paper, scissors, lizard, or spock"
    while @player1.selection.empty? || @player2.selection.empty? do
      puts "#{current_player.name}'s selection:"
      selection = gets.chomp.downcase
      if ["rock", "paper", "scissors", "lizard", "spock"].include?(selection)
        current_player.selection = selection
        current_player = current_player == @player1 ? @player2 : @player1
      end
    end
  end

  def check_winner
    return "draw" if @player1.selection == @player2.selection

    winning_selection = ""
    @win_conditions.each do |condition|
      if condition[:selections].include?(@player1.selection) && condition[:selections].include?(@player2.selection)
        winning_selection = condition[:winner]
        break
      end
    end
    if @player1.selection == winning_selection
      return @player1
    else
      return @player2
    end
  end

  def print_scores
    puts
    puts "Current Scores"
    puts "#{@player1.name}: #{@player1.score}"
    puts "#{@player2.name}: #{@player2.score}"
    puts
  end

  def check_game_over
    @game_over = @player1.score == @winning_score || @player2.score == @winning_score
  end

  def announce_winner
    winner = @player1.score > @player2.score ? @player1 : @player2
    puts "#{winner.name} wins! Congratulations!"
  end

  def game_loop
    until @game_over do
      get_selections
      winner = check_winner
      if winner == "draw"
        puts "It's a draw! Try again."
      else
        puts "#{winner.name} won this round!"
        winner.score += 1
        check_game_over
      end
      @player1.selection = ""
      @player2.selection = ""
      print_scores
    end
    announce_winner
    exit
  end
end

GameController.new
