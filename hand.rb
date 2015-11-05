require_relative 'card'

class Hand

  include Comparable

  attr_reader :cards

  def initialize cards
    @cards = cards.map { |card| Card.new card }.sort
  end

  def value
  end

  def flush?
    cards.map(&:suit).uniq == 1
  end

  def straight_flush?
    flush? &&
    Card.consecutive_valued?(cards)
  end

  def royal_flush?
    flush? &&
    (cards.map(&:rank) == %w[T J Q K A])
  end
end
