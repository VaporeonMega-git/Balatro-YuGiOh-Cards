--- STEAMODDED HEADER
--- MOD_NAME: Yu-Gi-Oh Jokers
--- MOD_ID: YuGiOh
--- MOD_AUTHOR: [VaporeonMega]
--- MOD_DESCRIPTION: Adds the five exodia cards as jokers.
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- BADGE_COLOR: c7638f
--- PREFIX: ygo

SMODS.Atlas {
  key = "YGOJokers",
  path = "YGOJokers.png",
  px = 71,
  py = 95
}


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
  cost = 6,
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
  rarity = 2,
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
  rarity = 2,
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
  rarity = 2,
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
  rarity = 2,
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

-- SMODS.Joker {
--   key = 'time_wizard',
--   loc_txt = {
--     name = 'Time Wizard',
--     text = {
--       "#3# in #4# chance to",
--       "give {X:mult,C:white}X#1#{} chips and mult",
--       "or destroy a random joker",
--       "and give {X:mult,C:white}X#2#{} chips and mult"
--     }
--   },
--   config = {extra = {success = 6, fail = 0, odds_num = 1, odds_den = 2}},
--   loc_vars = function(self, info_queue, card)
--     return {vars = {card.ability.extra.success, card.ability.extra.fail, G.GAME.probabilities.normal * card.ability.extra.odds_num, card.ability.extra.odds_den}}
--   end,
--   rarity = 1,
--   atlas = 'YGOJokers',
--   pos = {x=0, y=1},
--   cost = 4,
--   calculate = function(self, card, context)
--     if context.joker_main then
--       if pseudorandom('time_wizard') < G.GAME.probabilities.normal * card.ability.extra.odds_num / card.ability.extra.odds_den then
--         return {
--           Xmult_mod = card.ability.extra.success,
--           message = localize { type = 'variable', key = 'a_Xmult', vars = { card.ability.extra.success } }
--         }
--       else
--         joker_to_destroy = pseudorandom('time_wizard') * tablelength(G.jokers.cards),
--         print(tostring(joker_to_destroy)),
--         G.jokers.cards[joker_to_destroy]:remove(),
--         G.jokers.remove_card(G.jokers.cards[joker_to_destroy])
--         return {
--           Xmult_mod = card.ability.extra.fail,
--           message = localize { type = 'variable', key = 'a_Xmult', vars = { card.ability.extra.fail } }
--         }
--       end
--     end
--   end
-- }