require 'rspec'
require 'hand'

describe Hand do
  subject(:hand){Hand.new}

  it "initializes empty"



  it "receives cards from the deck"

  it "discards back to the deck"
  it "doesn't keep copies of cards"

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
