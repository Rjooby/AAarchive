require 'rspec'
require 'player'

describe Player do
  subject(:player) do
    Player.new("Ronald Joo", 84_000)
  end

  it "has a name" do
    expect(player.name).to eq("Ronald Joo")
  end

  it "has a bankroll" do
    expect(player.bankroll).to eq(84_000)
  end

  it "starts with an empty hand" do
    expect(player.hand).to be_empty
  end



  describe "#discard(deck)" do
    let(:deck) { double("deck") }

    it "discards cards" do
      expect(hand).to receive(:return_cards).with(deck)
      player.discard(deck)
    end
  end

  describe "#return_cards" do
    let(:deck) { double("deck") }
    let(:hand) { double("hand", :return_cards => nil) }

    before(:each) { player.hand = hand }

    it "returns player's cards to the deck" do
      expect(hand).to receive(:return_cards).with(deck)
      player.return_cards(deck)
    end

    it "resets hand to nil" do
      player.return_cards(deck)
      expect(player.hand).to be_nil
    end
  end

    # expect(player.discard)

  end

  it "places bets"


  it "prompts fold, see, or raise"

  it "busts"

  it "receives pot"

end
