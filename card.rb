require 'pry'

class Card
  include Comparable

  PIPS = %w[2 3 4 5 6 7 8 9 T]
  FACES = %w[J Q K A]
  VALUES = PIPS + FACES

  def self.consecutive_valued? cards
    card_values = cards.map(&:rank)
    VALUES.each_cons(5).any? do |section|
      card_values == section
    end
  end

  attr_reader :suit, :rank

  def initialize card
    @rank = parse_rank card
    @suit = prase_suit card
  end

  def <=>(other)
    rank <=> other.rank
  end

  def face?
    FACES.include? rank
  end

  def value
    VALUES.index rank
  end

    private

    def prase_suit card
      card[1]
    end

    def parse_rank card
      card[0]
    end
end
