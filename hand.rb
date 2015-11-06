require_relative 'card'

class Hand

  attr_reader :cards

  def initialize cards
    @cards = cards.map { |card| Card.new card }.sort
  end

  def high_card
    cards.last
  end

  def one_pair?
    counts.count(2) == 1
  end

  def one_pair
    pairs
  end

  def two_pairs?
    counts.count(2) == 2
  end

  def two_pairs
    pairs
  end

  def three_of_a_kind?
    counts.count(3) == 1
  end

  def three_of_a_kind
    triplets
  end

  def straight?
    Card.consecutive_valued? cards
  end

  def straight
    cards
  end

  def flush?
    cards.map(&:suit).uniq == 1
  end

  def flush
    cards
  end

  def full_house?
    (values.uniq == 2) && three_of_a_kind?
  end

  def full_house
    cards
  end

  def four_of_a_kind?
    (values.uniq == 2) && !full_house?
  end

  def four_of_a_kind
    quadruplets
  end

  def straight_flush?
    flush? &&
    Card.consecutive_valued?(cards)
  end

  def straight_flush
    cards
  end

  def royal_flush?
    flush? &&
    (cards.map(&:rank) == %w[T J Q K A])
  end

  def royal_flush
    cards
  end

    private

    def pairs
      histo = {}
      cards.each do |card|
        histo[card.rank] ||= 0
        histo[card.rank] += 1
      end
      cards.select do |card|
        histo[card.rank] == 2
      end
    end

    def triplets
      histo = {}
      cards.each do |card|
        histo[card.rank] ||= 0
        histo[card.rank] += 1
      end
      cards.select do |card|
        histo[card.rank] == 3
      end
    end

    def quadruplets
      histo = {}
      cards.each do |card|
        histo[card.rank] ||= 0
        histo[card.rank] += 1
      end
      cards.select do |card|
        histo[card.rank] == 4
      end
    end

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
