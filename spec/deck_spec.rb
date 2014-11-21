require 'rspec'
require 'deck'

describe Deck do
  subject(:all_cards){ Deck.all_cards }

  it "has every card exactly once" do
    deduped_cards = all_cards
      .map { |card| [card.suit, card.value] }
      .uniq
      .count
    expect(deduped_cards).to eq(52)
  end

  it "should initialize with 52 cards" do
    expect(all_cards.count).to eq(52)
  end

  it "can accept a deck" do
    cards = [Card.new(:four, :hearts),
              Card.new(:six, :clubs),
              Card.new(:queen, :diamonds)]

    deck = Deck.new(cards)

    expect(deck.count).to eq(3)
  end

  it "does not expose its cards directly" do
    expect(deck).not_to respond_to(:cards)
  end

  let(:deck) { Deck.new(all_cards) }

  describe "#shuffle" do
    it "shuffles cards" do
      expect(deck.shuffle).not_to eq(deck)
    end

    it "shuffles the same deck randomly each time" do
      deck1 = Deck.new
      deck2 = deck1
      deck2.shuffle
      deck1.shuffle

      expect(deck1).not_to eq(deck2)
    end
  end

  describe "#deal(number)" do
    cards = [Card.new(:four, :hearts),
            Card.new(:six, :clubs),
            Card.new(:queen, :diamonds)]

    deck = Deck.new(cards)
    cards2 = cards.dup
    it "deals off the top" do
      expect(deck.deal).to eq(cards2[0..0])
    end

    it "deals multiples cards" do
      expect(deck.deal(2)).to eq(cards2[1..2])
    end

    it "doesn't deal when empty" do
      expect{deck.deal}.to raise_error
    end
  end

  describe "#return" do
    cards = [Card.new(:four, :hearts),
              Card.new(:six, :clubs),
              Card.new(:queen, :diamonds)]

    deck_card = [Card.new(:seven, :spades)]

    deck_cards = Deck.new(deck_card)

    it "puts discarded cards on the bottom" do
      expect(deck_cards.return(cards).count).to eq(4)
      expect(deck_cards.deal).to eq(deck_card)
    end
  end



end
