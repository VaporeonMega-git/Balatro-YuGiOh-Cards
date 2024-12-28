SMODS.Consumable {
  key = "graceful_charity",
  set = "spell",
  loc_txt = {
    name = 'Graceful Charity',
    text = {
      "Grants a free shop reroll"
    }
  },
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'basic'}
  end,
  atlas = 'YGOSpells',
  pos = {x = 0, y = 0},
  cost = 2,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
    calculate_reroll_cost(true)
  end
}

SMODS.Consumable {
    key = "pot_of_greed",
    set = "spell",
    loc_txt = {
      name = 'Pot Of Greed',
      text = {
        "Draw 2 cards"
      }
    },
    loc_vars = function(self, info_queue, center)
      info_queue[#info_queue+1] = {set = 'Other', key = 'basic'}
    end,
    atlas = 'YGOSpells',
    pos = {x = 1, y = 0},
    cost = 8,
    can_use = function(self, card)
      if G.GAME.facing_blind then
        return true
      elseif G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
        return true
      else
        return false
      end
    end,
    use = function(self, card, area, copier)
        G.FUNCS.draw_from_deck_to_hand(2)
    end
  }