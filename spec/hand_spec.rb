require 'rspec'
require 'hand'

describe Hand do
  subject(:hand){Hand.new}

  it "responds to empty"
  it "initializes empty" do
    expect(hand).to be_empty
  end

  it "receives cards from the deck"


  describe "#return_cards(deck)"
    it "empties itself into the deck" do
      # put cards in hand
      # return cards
      expect(deck).to receive(return).with(cards)
    end

    it "discards specific cards to the deck" do
      expect(deck).to receive(return).with(cards[1])
    end
  end

  # describe "#discards"
  # it "doesn't keep copies of cards"

  describe "#beats?" do

    it "Royal Flush beats Straight Flush"
    it "Straight Flush beats Four of a Kind"
    it "Four of a Kind beats Full House"
    it "Full House beats Flush"
    it "Flush beats Straight"
    it "Straight beats 3 of a Kind"
    it "3 of a Kind beats 2 Pair"
    it "2 Pair beats 1 Pair"
    it "1 Pair beats High card"
    it "High cards have order"

    it "handles ties"
    # TODO : More tests

  end

end
