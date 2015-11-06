class Game

  RANKS = [:royal_flush?,
           :straight_flush?,
           :four_of_a_kind?,
           :full_house?,
           :flush?,
           :straight?,
           :three_of_a_kind?,
           :two_pairs?,
           :one_pair?]
  HANDS = [:high_card,
           :one_pair,
           :two_pairs,
           :three_of_a_kind,
           :straight,
           :flush,
           :full_house,
           :four_of_a_kind,
           :straight_flush,
           :royal_flush]

  def initialize player_one_hand, player_two_hand
    @player_one_hand = player_one_hand
    @player_two_hand = player_two_hand
  end

  def play
    player_one_rank = rank_hand(player_one_hand)
    player_two_rank = rank_hand(player_two_hand)

    if player_one_rank > player_two_rank
      :player_one
    elsif player_one_rank < player_two_rank
      :player_two
    else
      break_tie(player_one_hand, player_two_hand)
    end
  end

    private

    attr_reader :player_one_hand, :player_two_hand

    def break_tie player_one_hand, player_two_hand
      rank_number = rank_hand(player_one_hand)
      player_one_cards = player_one_hand.send(HANDS[rank_number])
      player_two_cards = player_two_hand.send(HANDS[rank_number])

      if player_one_cards.max.value > player_two_cards.max.value
        :player_one
      elsif player_one_cards.max.value < player_two_cards.max.value
        :player_two
      else
        if player_one_hand.max.value > player_two_hand.max.value
          :player_one
        else
          :player_two
        end
      end
    end

    def rank_hand hand
      rank = RANKS.index { |rank| hand.send(rank) }
      rank ? 9 - rank : 0
    end
end
