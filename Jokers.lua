require "math"

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
  key = 'exodia_forbidden_one',
  loc_txt = {
    name = 'Exodia the Forbidden One',
    text = {
      "If you have all other exodia",
      "pieces, {C:mult}+#1#{} Mult"
      -- "pieces, {C:mult}+naneinf{} Mult"
    }
  },
  config = {extra = {mult = 5 * (10 ^ 99)}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 3,
  atlas = 'YGOJokers',
  pos = {x=0, y=0},
  cost = 7,
  calculate = function(self, card, context)
    -- card.ability.extra.mult = math.huge
    if context.joker_main then
      if jokers_contains("j_ygo_exodia_left_arm") and jokers_contains("j_ygo_exodia_right_arm") and jokers_contains("j_ygo_exodia_left_leg") and jokers_contains("j_ygo_exodia_right_leg") then
        orig_amt = G.GAME.round_scores['hand'].amt
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 10.0,
          func = function()
            G.GAME.round_scores['hand'].amt = orig_amt
            return true end }))
        return {
          mult_mod = card.ability.extra.mult,
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
    key = 'dark_magician',
    loc_txt = {
      name = 'Dark Magician',
      text = {
        "{C:green}#1# in #2#{} chance for",
        "played cards with",
        "{C:spades}Spade{} suit to give",
        "{X:mult,C:white}X#3#{} Mult when scored"
      }
    },
    config = {extra = {odds_num = 1, odds_den = 2, Xmult = 1.5}},
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.odds_num * (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds_den, card.ability.extra.Xmult}}
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
      'Retrigger each played {C:spades}Spade{} #1#',
      'time for each {C:attention}Dark Magician{} joker',
    }
  },
  config = {extra = {repetitions = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.repetitions}}
  end,
  rarity = 2,
  atlas = 'YGOJokers',
  pos = {x=2, y=1},
  cost = 7,
  calculate = function(self, card, context)
    if context.repetition then
      if context.cardarea == G.play then
        if context.other_card:is_suit("Spades") then
          local rep = 0
          for k, v in ipairs(G.jokers.cards) do
            if v.ability.name == 'j_ygo_dark_magician' or v.ability.name == 'j_ygo_dark_magician_girl' then
              rep = rep + 1
            end
          end
          rep = rep * card.ability.extra.repetitions
          return {
            message = localize('k_again_ex'),
            repetitions = rep,
            card = card
          }
        end
      end
    end
  end
}

SMODS.Joker {
  key = "maiden_with_eyes_of_blue",
  loc_txt = {
    name = 'Maiden with Eyes of Blue',
    text = {
      "{C:green}#1# in #2#{} chance to {C:attention}self-destruct{}",
      "and spawn a {C:chips,T:blue_eyes_white_drageon}Blue-Eyes White Dragon{}",
      "in the next shop"
    }
  },
  rarity = 3,
  atlas = "YGOJokers",
  pos = {x=4, y=2},
  cost = 10,
  no_pool_flag = 'maiden_with_eyes_of_blue_used',
  config = {extra = {odds_num = 1, odds_den = 8}},
  loc_vars = function(self, info_queue, card)
    return { vars = {card.ability.extra.odds_num, card.ability.extra.odds_den} }
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			if pseudorandom('maiden_with_eyes_of_blue') < card.ability.extra.odds_num * G.GAME.probabilities.normal / card.ability.extra.odds_den then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				G.GAME.pool_flags.sage_with_eyes_of_blue_used = true
        local tag = Tag("tag_ygo_blue_eyes")
        if not tag.ability then
          tag.ability = {}
        end
        add_tag(tag)
				return {
					message = 'Summon!'
				}
			else
				return {
					message = 'No Summon!'
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
  config = {extra = {chips = 300}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 'ygo_ultra_rare',
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

SMODS.Joker {
  key = 'red_eyes_black_dragon',
  loc_txt = {
    name = 'Red-Eyes Black Dragon',
    text = {
      "{C:mult}+#1#{} Mult"
    }
  },
  config = {extra = {mult = 270}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 'ygo_ultra_rare',
  atlas = 'YGOJokers',
  pos = {x=2, y=2},
  cost = 20,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
  end
}

time_wizard_non_eternals = function()
  local nons = {}
  local j = 1
  for i=#G.jokers.cards, 1, -1 do
    if not G.jokers.cards[i].ability.eternal then
      nons[j] = G.jokers.cards[i]
      j = j + 1
    end
  end
  return nons
end

SMODS.Joker {
  key = 'time_wizard',
  loc_txt = {
    name = 'Time Wizard',
    text = {
      "{C:green}50/50{} chance to",
      "give {X:mult,C:white}X#1#{} Mult or",
      "{C:attention}destroy{} a random joker"
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
      if not G.GAME.probabilities.time_wizard then
        G.GAME.probabilities.time_wizard = 0.0 -- addative
      end
      if pseudorandom('time_wizard') < (50.0 + G.GAME.probabilities.time_wizard) / 100.0 then
        return {
          Xmult_mod = card.ability.extra.success,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.success } }
        }
      else
        non_eternals = time_wizard_non_eternals()
        if #non_eternals > 0 then
          local joker_to_destroy = math.floor(pseudorandom('time_wizard') * tablelength(non_eternals) + 1)
          non_eternals[joker_to_destroy]:explode()
          -- G.jokers.remove_card(non_eternals[joker_to_destroy])
        end
        return {
          Xmult_mod = card.ability.extra.fail,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.fail } }
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'slifer_the_executive_producer',
  loc_txt = {
    name = 'Slifer the Sky Dragon',
    text = {
      "{C:mult}+#1#{} Mult for each",
      "card in hand"
    }
  },
  config = {extra = {mult = 50}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 'ygo_egyptian_god',
  atlas = 'YGOJokers',
  pos = {x=4, y=1},
  cost = 20,
  calculate = function(self, card, context)
    if context.joker_main then
      local total_mult = card.ability.extra.mult * tablelength(G.hand.cards)
      return {
        mult_mod = total_mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { total_mult } }
      }
    end
  end
}

SMODS.Joker {
  key = 'obelisk_the_tormentor',
  loc_txt = {
    name = 'Obelisk the Tormentor',
    text = {
      "{C:chips}+#1#{} Chips",
      "{C:mult}+#2#{} Mult",
      "After selling {C:attention}#3#{} cards, create",
      "a {C:dark_edition}Negative{} {C:planet}Mystical Space Typhoon{} card"
    }
  },
  config = {extra = {chips = 100, mult = 100, left_to_sell = 2, need_to_sell = 2}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.left_to_sell, card.ability.extra.need_to_sell}}
  end,
  rarity = 'ygo_egyptian_god',
  atlas = 'YGOJokers',
  pos = {x=0, y=2},
  cost = 20,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        mult_mod = card.ability.extra.mult,
        message = '+' .. card.ability.extra.chips .. ' Chips, ' ..
                  localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    elseif context.selling_card then
      card.ability.extra.left_to_sell = card.ability.extra.left_to_sell - 1
      if card.ability.extra.left_to_sell <= 0 then
        local tarot = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_ygo_mystical_space_typhoon', nil)
        -- card:add_to_deck()
        G.consumeables:emplace(tarot)
        
        if not tarot.edition then
          tarot.edition = {}
        end
        tarot.edition.negative = true
        tarot.edition.type = 'negative'

        card.ability.extra.left_to_sell = card.ability.extra.need_to_sell
      end
    end
  end
}

SMODS.Joker {
  key = 'the_winged_dragon_of_ra',
  loc_txt = {
    name = 'The Winged Dragon of Ra',
    text = {
      "Play only {C:attention}#1#{} hand",
      "{X:mult,C:white}X#2#{} Mult, {C:mult}+{X:mult,C:white}X#3#{} for",
      "each hand lost"
    }
  },
  config = {extra = {hands = 1, Xmult = 1, Xmult_mod = 2}, memory = {original_hands = 4, original_Xmult = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.hands, card.ability.extra.Xmult, card.ability.extra.Xmult_mod, card.ability.extra.original_Xmult}}
  end,
  rarity = 'ygo_egyptian_god',
  atlas = 'YGOJokers',
  pos = {x=1, y=2},
  cost = 20,
  calculate = function(self, card, context)
    if context.ending_shop then
      card.ability.memory.original_hands = G.GAME.round_resets.hands
      card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod * (card.ability.memory.original_hands - 1))
      G.GAME.round_resets.hands = 1
    elseif context.end_of_round then
      G.GAME.round_resets.hands = card.ability.memory.original_hands
      card.ability.extra.Xmult = card.ability.memory.original_Xmult
    elseif context.joker_main then
      return {
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
      }
    end
  end
}

-- SMODS.Joker {
--   key = 'the_winged_dragon_of_ra',
--   loc_txt = {
--     name = 'The Winged Dragon of Ra',
--     text = {
--       "{X:mult,C:white}X#2#{} Mult",
--       "When a card is destroyed,",
--       "gain the card's rank value",
--       "times {C:mult}#1#{} as Xmult"
--     }
--   },
--   config = {extra = {Xmult_mod = 0.06, Xmult = 1}},
--   loc_vars = function(self, info_queue, card)
--     return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.Xmult}}
--   end,
--   rarity = 4,
--   atlas = 'YGOJokers',
--   pos = {x=1, y=2},
--   cost = 20,
--   calculate = function(self, card, context)
--     if context.remove_playing_cards then
--       local amnt = 0
--       for k, val in ipairs(context.removed) do
--           amnt = amnt + (val:get_id() * card.ability.extra.Xmult_mod)
--       end
--       if amnt > 0 then
--         card.ability.extra.Xmult = card.ability.extra.Xmult + amnt
--         G.E_MANAGER:add_event(Event({
--           func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}}); return true
--         end}))
--       end
--     elseif context.joker_main then
--       return {
--         Xmult_mod = card.ability.extra.Xmult,
--         message = localize { type = 'variable', key = 'a_Xmult', vars = { card.ability.extra.Xmult } }
--       }
--     end
--   end
-- }

SMODS.Joker {
  key = 'luster_dragon',
  loc_txt = {
    name = 'Luster Dragon',
    text = {
      "Played cards with",
      "{C:hearts}Heart{} suit give {C:chips}+#1#{}",
      "chips when scored"
    }
  },
  config = {extra = {chips = 50}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 2,
  atlas = 'YGOJokers',
  pos = {x=3, y=2},
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
  key = 'baby_dragon',
  loc_txt = {
    name = 'Baby Dragon',
    text = {
      "{C:chips}+#1#{} Chips",
      "{C:mult}+#2#{} Mult"
    }
  },
  config = {extra = {chips = 12, mult = 7}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.mult}}
  end,
  rarity = 1,
  atlas = 'YGOJokers',
  pos = {x=0, y=3},
  cost = 6,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        mult_mod = card.ability.extra.mult,
        message = '+' .. card.ability.extra.chips .. ' Chips, ' ..
                  localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
  end
}

SMODS.Joker {
  key = 'thousand_dragon',
  loc_txt = {
    name = 'Thousand Dragon',
    text = {
      "{C:chips}+#1#{} Chips",
      "{X:mult,C:white}X#2#{} Mult",
      "{C:inactive,s:0.8}Baby Dragon",
      "{C:inactive,s:0.8}Time Wizard",
    }
  },
  config = {extra = {chips = 24, Xmult = 2}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.Xmult}}
  end,
  rarity = 'ygo_fusion',
  atlas = 'YGOJokers',
  pos = {x=1, y=3},
  cost = 20,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        Xmult_mod = card.ability.extra.Xmult,
        message = '+' .. card.ability.extra.chips .. ' Chips, ' ..
                  localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.mult } }
      }
    end
  end
}

SMODS.Joker {
  key = 'blue_eyes_ultimate_dragon',
  loc_txt = {
    name = 'Blue-Eyes Ultimate Dragon',
    text = {
      "{C:chips}+#1#{} Chips",
      "{C:inactive,s:0.8}Blue-Eyes White Dragon x3"
    }
  },
  config = {extra = {chips = 900}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 'ygo_fusion',
  atlas = 'YGOJokers',
  pos = {x=2, y=3},
  cost = 40,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
      }
    end
  end
}

SMODS.Joker {
  key = 'summoned_skull',
  loc_txt = {
    name = 'Summoned Skull',
    text = {
      "{C:chips}+#1#{} Chips for each",
      "{C:spades}Spade{} held in hand"
    }
  },
  config = {extra = {h_chips = 25}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.h_chips}}
  end,
  rarity = 3,
  atlas = 'YGOJokers',
  pos = {x=3, y=3},
  cost = 8,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand then
      if context.other_card:is_suit("Spades") then
        return {
          h_chips = card.ability.extra.h_chips,
          card = context.other_card
        }
      end
    end
  end
}

SMODS.Joker {
  key = 'black_skull_dragon',
  loc_txt = {
    name = 'Black Skull Dragon',
    text = {
      "{C:chips}+#1#{} Chips for each",
      "{C:spades}Spade{} held in hand",
      "{C:mult}+#2#{} Mult",
      "{C:inactive,s:0.8}Summoned Skull",
      "{C:inactive,s:0.8}Red-Eyes Black Dragon"
    }
  },
  config = {extra = {h_chips = 32, mult = 270}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.h_chips, card.ability.extra.mult}}
  end,
  rarity = 'ygo_fusion',
  atlas = 'YGOJokers',
  pos = {x=4, y=3},
  cost = 40,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand then
      if context.other_card:is_suit("Spades") then
        return {
          h_chips = card.ability.extra.h_chips,
          card = context.other_card
        }
      end
    elseif context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
  end
}

is_card_and_not_debuffed = function(card, id)
  if card:get_id() == id and not card.debuff then
    return true
  end
  return
end

SMODS.Joker {
  key = 'kings_knight',
  loc_txt = {
    name = 'King\'s Knight',
    text = {
      "Retrigger each played",
      "{C:attention}King{} for each {C:attention}Queen{}",
      "or {C:attention}Jack{} held in hand"
    }
  },
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 1,
  atlas = 'YGOJokers2',
  pos = {x=0, y=0},
  cost = 6,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      if not is_card_and_not_debuffed(context.other_card, 13) then
        return
      end

      local reps = 0
      for i=#G.hand.cards, 1, -1 do
        if is_card_and_not_debuffed(G.hand.cards[i], 11) or is_card_and_not_debuffed(G.hand.cards[i], 12) then
          reps = reps + 1
        end
      end

      return {
        card = context.other_card,
        repetitions = reps,
        message = localize('k_again_ex')
      }
    end
  end
}

SMODS.Joker {
  key = 'queens_knight',
  loc_txt = {
    name = 'Queen\'s Knight',
    text = {
      "Retrigger each played",
      "{C:attention}Queen{} for each {C:attention}King{}",
      "or {C:attention}Jack{} held in hand"
    }
  },
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 1,
  atlas = 'YGOJokers2',
  pos = {x=1, y=0},
  cost = 6,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      if not is_card_and_not_debuffed(context.other_card, 12) then
        return
      end

      local reps = 0
      for i=#G.hand.cards, 1, -1 do
        if is_card_and_not_debuffed(G.hand.cards[i], 11) or is_card_and_not_debuffed(G.hand.cards[i], 13) then
          reps = reps + 1
        end
      end

      return {
        card = context.other_card,
        repetitions = reps,
        message = localize('k_again_ex')
      }
    end
  end
}

SMODS.Joker {
  key = 'jacks_knight',
  loc_txt = {
    name = 'Jack\'s Knight',
    text = {
      "Retrigger each played",
      "{C:attention}Jack{} for each {C:attention}King{}",
      "or {C:attention}Queen{} held in hand"
    }
  },
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    return {vars = {}}
  end,
  rarity = 1,
  atlas = 'YGOJokers2',
  pos = {x=2, y=0},
  cost = 6,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      if not is_card_and_not_debuffed(context.other_card, 11) then
        return
      end

      local reps = 0
      for i=#G.hand.cards, 1, -1 do
        if is_card_and_not_debuffed(G.hand.cards[i], 12) or is_card_and_not_debuffed(G.hand.cards[i], 13) then
          reps = reps + 1
        end
      end

      return {
        card = context.other_card,
        repetitions = reps,
        message = localize('k_again_ex')
      }
    end
  end
}

SMODS.Joker {
  key = 'witch_of_the_black_forest',
  loc_txt = {
    name = 'Witch of the Black Forest',
    text = {
      "Create a {C:planet}Spell{} or {C:tarot}Trap{}",
      "card when {C:attention}Blind{} is selected",
      "{C:inactive}(Must have room)"
    }
  },
  config = {extra = {chips = 900}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 2,
  atlas = 'YGOJokers2',
  pos = {x=3, y=0},
  cost = 8,
  calculate = function(self, card, context)
    if context.setting_blind then
      if G.consumeables.config.card_limit > #G.consumeables.cards then
        r1 = pseudorandom('ygo_witch_of_the_black_forest')
        if r1 < 0.15 then
            -- r2 = pseudorandom('ygo_spellpack')
            -- if r2 < 0.1 then
            --     c = create_card("trap_rare", G.pack_cards, nil, nil, true, true, nil, nil)
            -- else
                c = create_card("trap", G.consumeables, nil, nil, true, true, nil, nil)
                print(c.ability.name)
            -- end
            if c.ability.name == "Joker" then
              print("removed")
              c:remove()
              r1 = 0.20
            end
        end
        if r1 >= 0.15 then
          r2 = pseudorandom('ygo_witch_of_the_black_forest')
          if r2 < 0.1 then
              c = create_card("spell_rare", G.consumeables, nil, nil, true, true, nil, nil)
          else
              c = create_card("spell", G.consumeables, nil, nil, true, true, nil, nil)
          end
        end
        
        if c.ability.name == "Joker" then
          c:remove()
        else
          G.consumeables:emplace(c)
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Search!", colour = G.C.BLUE})
        end
      end
    end
  end
}
