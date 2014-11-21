require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new }

  it "can be initialized with a suit and value"

  card = Card.new(:spades, :king)

  it "should output its value" do
    expect(card.value)


end
