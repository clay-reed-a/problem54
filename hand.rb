require_relative 'card'

class Hand

  include Comparable

  attr_reader :cards

  def initialize cards
    @cards = cards.map { |card| Card.new card }.sort
  end

  def <=>(other)
    value <=> other.value
  end

  def value
    if royal_flush?
      8
    elsif straight_flush?
      7
    elsif four_of_a_kind?
      6
    elsif full_house?
      5
    elsif flush?
      4
    elsif three_of_a_kind?
      3
    elsif two_pairs?
      2
    elsif one_pair?
      1
    else
      0
    end
  end

  def one_pair?
    counts_count(2) == 1
  end

  def two_pairs?
    counts.count(2) == 2
  end

  def three_of_a_kind?
    counts.count(3) == 1
  end

  def straight?
    Card.consecutive_valued? cards
  end

  def flush?
    cards.map(&:suit).uniq == 1
  end

  def full_house?
    (values.uniq == 2) && three_of_a_kind?
  end

  def four_of_a_kind?
    (values.uniq == 2) && !full_house?
  end

  def straight_flush?
    flush? &&
    Card.consecutive_valued?(cards)
  end

  def royal_flush?
    flush? &&
    (cards.map(&:rank) == %w[T J Q K A])
  end

    private

    def values
      @values ||= cards.map(&:value)
    end

    def counts
      @counts ||= begin
        values.map do |value|
          values.count(value)
        end
      end
    end
end
