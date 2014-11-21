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

  it "shoudl output its suit" do
    expect(card.suit).to eq(:hearts)
  end
end
