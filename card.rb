class Card
  include Comparable

  PIPS = %w[2 3 4 5 6 7 8 9 10]
  FACES = %w[J Q K A]
  VALUES = PIPS + FACES

  attr_reader :suit, :rank

  def initialize card
    @rank = card[0]
    @suit = card[1]
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
end
