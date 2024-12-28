local function jokers_contains(val)
  for index, value in ipairs(G.jokers.cards) do
    if value:save().label == val then
      return true
    end
  end
  return false
end

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

SMODS.Joker {
  key = 'exodia_forbidden_one',
  loc_txt = {
    name = 'Exodia the Forbidden One',
    text = {
      "If you have all other exodia",
      "pieces, {X:mult,C:white}X#1#{} Mult"
    }
  },
  config = {extra = {Xmult = 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult}}
  end,
  rarity = 3,
  atlas = 'YGOJokers',
  pos = {x=0, y=0},
  cost = 7,
  calculate = function(self, card, context)
    if context.joker_main then
      if jokers_contains("j_ygo_exodia_left_arm") and jokers_contains("j_ygo_exodia_right_arm") and jokers_contains("j_ygo_exodia_left_leg") and jokers_contains("j_ygo_exodia_right_leg") then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          -- message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
          message = 'OBLITERATE'
        }
      end
    end
  end
}


SMODS.Joker {
  key = 'exodia_left_arm',
  loc_txt = {
    name = 'Left Arm of the Forbidden One',
    text = {
      "{C:mult}+#1#{} Mult"
    }
  },
  config = {extra = {mult = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 1,
  atlas = 'YGOJokers',
  pos = {x=3, y=0},
  cost = 4,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
    end
  end
}

SMODS.Joker {
  key = 'exodia_right_arm',
  loc_txt = {
    name = 'Right Arm of the Forbidden One',
    text = {
      "{C:mult}+#1#{} Mult"
    }
  },
  config = {extra = {mult = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 1,
  atlas = 'YGOJokers',
  pos = {x=2, y=0},
  cost = 4,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
    end
  end
}

SMODS.Joker {
  key = 'exodia_left_leg',
  loc_txt = {
    name = 'Left Leg of the Forbidden One',
    text = {
      "{C:mult}+#1#{} Mult"
    }
  },
  config = {extra = {mult = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 1,
  atlas = 'YGOJokers',
  pos = {x=1, y=0},
  cost = 4,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
    end
  end
}

SMODS.Joker {
  key = 'exodia_right_leg',
  loc_txt = {
    name = 'Right Leg of the Forbidden One',
    text = {
      "{C:mult}+#1#{} Mult"
    }
  },
  config = {extra = {mult = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 1,
  atlas = 'YGOJokers',
  pos = {x=4, y=0},
  cost = 4,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
    end
  end
}

SMODS.Joker {
  key = 'time_wizard',
  loc_txt = {
    name = 'Time Wizard',
    text = {
      "50/50 chance to",
      "give {X:mult,C:white}X#1#{} Mult or",
      "destroy a random joker"
    }
  },
  config = {extra = {success = 10, fail = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.success, card.ability.extra.fail}}
  end,
  rarity = 3,
  atlas = 'YGOJokers',
  pos = {x=0, y=1},
  cost = 7,
  calculate = function(self, card, context)
    if context.joker_main then
      if pseudorandom('time_wizard') < 1.0 / 2.0 then
        return {
          Xmult_mod = card.ability.extra.success,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.success } }
        }
      else
        joker_to_destroy = math.floor(pseudorandom('time_wizard') * tablelength(G.jokers.cards) + 1)
        G.jokers.cards[joker_to_destroy]:remove()
        G.jokers.remove_card(G.jokers.cards[joker_to_destroy])
        return {
          Xmult_mod = card.ability.extra.fail,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.fail } }
        }
      end
    end
  end
}

SMODS.Joker {
    key = 'dark_magician',
    loc_txt = {
      name = 'Dark Magician',
      text = {
        "#1# in #2# chance for",
        "played cards with",
        "{C:spades}Spade{} suit to give",
        "{X:mult,C:white}X#3#{} Mult when scored"
      }
    },
    config = {extra = {odds_num = 1, odds_den = 2, Xmult = 1.5}},
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.odds_num, card.ability.extra.odds_den, card.ability.extra.Xmult}}
    end,
    rarity = 2,
    atlas = 'YGOJokers',
    pos = {x=1, y=1},
    cost = 7,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.other_card:is_suit("Spades") and pseudorandom('bloodstone') < G.GAME.probabilities.normal*card.ability.extra.odds_num/card.ability.extra.odds_den then
          return {
            x_mult = card.ability.extra.Xmult,
            card = card
          }
        end
      end
    end
  }

SMODS.Joker {
  key = 'dark_magician_girl',
  loc_txt = {
    name = 'Dark Magician Girl',
    text = {
      "Played cards with",
      "{C:hearts}Heart{} suit to give",
      "{C:chips}+#1#{} Chips when scored"
    }
  },
  config = {extra = {chips = 50}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 2,
  atlas = 'YGOJokers',
  pos = {x=2, y=1},
  cost = 7,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit("Hearts") then
        return {
          chips = card.ability.extra.chips,
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'blue_eyes_white_dragon',
  loc_txt = {
    name = 'Blue-Eyes White Dragon',
    text = {
      "{C:chips}+#1#{} Chips"
    }
  },
  config = {extra = {chips = 500}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 4,
  atlas = 'YGOJokers',
  pos = {x=3, y=1},
  cost = 20,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
      }
    end
  end
}