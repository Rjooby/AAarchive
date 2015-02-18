require 'card.rb'

class Deck

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def self.all_cards
    all_cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end

    all_cards
  end

  def count
    @cards.count
  end

  def deal(n = 1)
    raise "no more cards" if @cards.empty?
    @cards.shift(n)
  end

  def shuffle
    @cards.shuffle!
  end

  def return(cards)
    @cards += cards
  end

  def ==(other_deck)
    return false if @cards.count != other_deck.count

    @cards.each do |card|
      other_deck.cards.each do |other_card|
        return false if card != other_card
      end
    end

    true
  end

  protected
  attr_reader :cards

end
