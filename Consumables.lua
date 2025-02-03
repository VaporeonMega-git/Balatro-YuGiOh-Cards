SMODS.Consumable {
  key = "graceful_charity",
  set = "spell",
  loc_txt = {
    name = 'Graceful Charity',
    text = {
      "Discard {C:attention}#1#{} cards",
      "and draw {C:attention}#2#{}"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {2, 3}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 0, y = 0},
  cost = 2,
  can_use = function(self, card)
    if #G.hand.highlighted == 2 then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    G.FUNCS.discard_cards_from_highlighted(nil, true)
    G.FUNCS.draw_from_deck_to_hand(3)
  end
}

-- SMODS.Consumable {
--   key = "graceful_charity",
--   set = "spell",
--   loc_txt = {
--     name = 'Graceful Charity',
--     text = {
--       "Grants a free shop reroll"
--     }
--   },
--   loc_vars = function(self, info_queue, center)
--     return {vars = {}}
--   end,
--   atlas = 'YGOSpells',
--   pos = {x = 0, y = 0},
--   cost = 2,
--   can_use = function(self, card)
--     return true
--   end,
--   use = function(self, card, area, copier)
--     G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
--     calculate_reroll_cost(true)
--   end
-- }

SMODS.Consumable {
  key = "pot_of_greed",
  set = "spell",
  loc_txt = {
    name = 'Pot Of Greed',
    text = {
      "Draw {C:attention}#1#{} cards"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {2}}
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

SMODS.Consumable {
  key = "enemy_controller",
  set = "spell",
  loc_txt = {
    name = 'Enemy Controller',
    text = {
      "Remove {C:attention}eternal{}, {C:attention}perishable{},",
      "and {C:attention}rental{} from {C:attention}1{} selected joker"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {2, 3}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 2, y = 0},
  cost = 2,
  can_use = function(self, card)
    if #G.jokers.highlighted == 1 then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    G.jokers.highlighted[1]:set_eternal(false)
    G.jokers.highlighted[1].ability.perishable = nil
    G.jokers.highlighted[1]:set_rental(false)
  end
}

SMODS.Consumable {
  key = "mystical_space_typhoon",
  set = "spell",
  loc_txt = {
    name = 'Mystical Space Typhoon',
    text = {
      "Destroy {C:attention}#1#{} playing card"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {1}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 3, y = 0},
  cost = 3,
  can_use = function(self, card)
    if #G.hand.highlighted == 1 then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    local destroyed_cards = {G.hand.highlighted[1]}
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
      play_sound('tarot1')
      card:juice_up(0.3, 0.5)
      return true end }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function() 
        G.hand.highlighted[1]:start_dissolve(nil, i == #G.hand.highlighted)
        return true end }))
    delay(0.3)
    for i = 1, #G.jokers.cards do
        G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards})
    end
  end
}

SMODS.Consumable {
  key = "raigeki",
  set = "spell_rare",
  loc_txt = {
    name = 'Raigeki',
    text = {
      "Destroy {C:attention}all{} selected",
      "playing cards"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 4, y = 0},
  cost = 10,
  can_use = function(self, card)
    if #G.hand.highlighted > 0 then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    local destroyed_cards = {}
    for i=#G.hand.highlighted, 1, -1 do
      destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
      play_sound('tarot1')
      card:juice_up(0.3, 0.5)
      return true end }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function() 
        for i=#G.hand.highlighted, 1, -1 do
          local card = G.hand.highlighted[i]
          if card.ability.name == 'Glass Card' then 
            card:shatter()
          else
            card:start_dissolve(nil, i == #G.hand.highlighted)
          end
        end
        return true end }))
  end
}

SMODS.Consumable {
  key = "swords_of_revealing_light",
  set = "spell_rare",
  loc_txt = {
    name = 'Swords of Revealing Light',
    text = {
      "{C:red}+#1#{} Discards this round"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {3}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 0, y = 1},
  cost = 10,
  can_use = function(self, card)
    if G.GAME.facing_blind ~= nil then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + 3;
  end
}

SMODS.Consumable {
  key = "change_of_heart",
  set = "spell",
  loc_txt = {
    name = 'Change of Heart',
    text = {
      "Converts up to {C:attention}#1#{} selected",
      "cards to their opposite suit"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {2}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 1, y = 1},
  cost = 3,
  can_use = function(self, card)
    if #G.hand.highlighted > 0 and #G.hand.highlighted < 3 then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    for i=#G.hand.highlighted, 1, -1 do
      c = G.hand.highlighted[i]
      if c.base.suit == "Hearts" then
        c:flip()
        c:change_suit('Spades')
      elseif c.base.suit == "Spades" then
        c:flip()
        c:change_suit('Hearts')
      elseif c.base.suit == "Clubs" then
        c:flip()
        c:change_suit('Diamonds')
      elseif c.base.suit == "Diamonds" then
        c:flip()
        c:change_suit('Clubs')
      end
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 1.5,
      func = function() 
        for i=#G.hand.highlighted, 1, -1 do
          G.hand.highlighted[i]:flip()
        end
        return true end }))
  end
}

SMODS.Consumable {
  key = "gagagashield",
  set = "trap",
  loc_txt = {
    name = 'Gagagashield',
    text = {
      "Give a joker {C:attention}eternal{}",
      "until the end of the round"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {2}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 2, y = 1},
  cost = 10,
  can_use = function(self, card)
    if #G.jokers.highlighted == 1 and (not G.jokers.highlighted[1].ability.eternal) and G.jokers.highlighted[1].config.center.eternal_compat then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    c = G.jokers.highlighted[1]
    c:set_eternal(true)
    local tag = Tag("tag_ygo_gagagashield_tag")
    if not tag.ability then
      tag.ability = {}
    end
    if not tag.ability.joker then
      tag.ability.joker = c
    end
    add_tag(tag)
  end
}

polymerization_compat = function(jokers, fusion)
  local compat = {}
  local checking = fusion_reqs(fusion)

  -- Check all jokers against the checking table
  for i=#jokers, 1, -1 do
    if checking[jokers[i].ability.name] and checking[jokers[i].ability.name] > 0 then
      checking[jokers[i].ability.name] = checking[jokers[i].ability.name] - 1
      compat[i] = true
    end
  end

  -- Did everything get found?
  for key, value in pairs(checking) do
    if value > 0 then
      return nil
    end
  end

  return compat
end

fusion_reqs = function(fusion)
  if fusion == "thousand_dragon" then
    return {
      j_ygo_baby_dragon = 1,
      j_ygo_time_wizard = 1
    }
  elseif fusion == "blue_eyes_ultimate_dragon" then
    return {
      j_ygo_blue_eyes_white_dragon = 3
    }
  elseif fusion == "black_skull_dragon" then
    return {
      j_ygo_summoned_skull = 1,
      j_ygo_red_eyes_black_dragon = 1
    }
  end
end

polymerization_destroy = function(materials)
  local destroyed_cards = {}
  for i=#G.jokers.cards, 1, -1 do
    if materials[i] then
      destroyed_cards[#destroyed_cards+1] = G.jokers.cards[i]
    end
  end
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function() 
      for i=#destroyed_cards, 1, -1 do
        local card = destroyed_cards[i]
        card:start_dissolve(nil, i == #destroyed_cards)
      end
      return true end }))
end

SMODS.Consumable {
  key = "polymerization",
  set = "spell",
  loc_txt = {
    name = 'Polymerization',
    text = {
      "{C:tarot}Fuse{} {C:attention}2+{} compatable jokers."
    }
  },
  loc_vars = function(self, info_queue, center)
    return {vars = {2}}
  end,
  atlas = 'YGOSpells',
  pos = {x = 3, y = 1},
  cost = 10,
  can_use = function(self, card)
    if polymerization_compat(G.jokers.cards, "thousand_dragon") then
      return true
    elseif polymerization_compat(G.jokers.cards, "blue_eyes_ultimate_dragon") then
      return true
    elseif polymerization_compat(G.jokers.cards, "black_skull_dragon") then
      return true
    else
      return false
    end
  end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
      play_sound('tarot1')
      card:juice_up(0.3, 0.5)
      return true end }))
    if polymerization_compat(G.jokers.cards, "thousand_dragon") then
      materials = polymerization_compat(G.jokers.cards, "thousand_dragon")
      fusion = create_card("Joker", G.jokers, nil, nil, nil, nil, ('j_ygo_thousand_dragon'))
    elseif polymerization_compat(G.jokers.cards, "blue_eyes_ultimate_dragon") then
      materials = polymerization_compat(G.jokers.cards, "blue_eyes_ultimate_dragon")
      fusion = create_card("Joker", G.jokers, nil, nil, nil, nil, ('j_ygo_blue_eyes_ultimate_dragon'))
    elseif polymerization_compat(G.jokers.cards, "black_skull_dragon") then
      materials = polymerization_compat(G.jokers.cards, "black_skull_dragon")
      fusion = create_card("Joker", G.jokers, nil, nil, nil, nil, ('j_ygo_black_skull_dragon'))
    else
      print("[ygo] Couldn't fuse?")
      return
    end
    polymerization_destroy(materials)
    G.jokers:emplace(fusion)
  end
}
