require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:hearts, :three) }

  it "can be initialized with a suit and value" do
    card = Card.new(:spades, :king)
  end

  it "should output its value" do
    expect(card.value).to eq(:three)
  end

  it "should output its suit" do
    expect(card.suit).to eq(:hearts)
  end

  describe "#to_s" do
    it "should put a string of card" do
      expect(card.to_s).to eq("3♥")
    end
  end

  #TODO test for suits, values, and poker values hashes

end
