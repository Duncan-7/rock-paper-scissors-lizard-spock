class Player
  attr_reader :name
  attr_accessor :score, :selection

  def initialize()
    @name = get_player_name
    @score = 0
    @selection = ""
  end

  def get_player_name
    puts "Enter your name:"
    name = gets.chomp.capitalize
  end
end
