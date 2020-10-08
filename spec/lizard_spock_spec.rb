require 'game_controller'
require 'player'

describe "Rock Paper Scissors Lizard Spock" do
  before(:each) do
    allow_any_instance_of(Player).to receive(:gets).and_return("John\n")
    allow_any_instance_of(GameController).to receive(:get_winning_score).and_return(3)
  end

  describe Player do
    it "Creates a new player" do
      expect(Player.new).to be_instance_of Player
    end

    it "asks player for their name" do
      expect{Player.new}.to output("Enter your name:\n").to_stdout
    end

    it "Stores player name" do
      expect(Player.new().name).to eq "John"
    end

    it "Initial score 0" do
      expect(Player.new().score).to eq 0
    end
    #
    it "Initial selection blank" do
      expect(Player.new().selection).to eq ""
    end
  end

  describe GameController do
    it "Creates an instance of game controller" do
      expect(GameController.new()).to be_instance_of GameController
    end

    it "Create player 1 when instantiated" do
      expect(GameController.new.player1).to be_instance_of Player
    end

    it "Create player 2 when instantiated" do
      expect(GameController.new.player2).to be_instance_of Player
    end

    it "Gets winning score when instantiate" do
      expect(GameController.new.winning_score).to eq 3
    end

    it "Generates win conditions" do
      expect(GameController.new.win_conditions).to be_instance_of Hash
    end
  end
end
