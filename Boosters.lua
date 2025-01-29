SMODS.Booster {
  name = "Spell Pack",
  key = "spellpack_normal_1",
  loc_txt = {
    name = 'Spell Pack',
    text = {
      "Choose 1 of up to",
      "3 Spell cards to",
      "be used immediately"
    }
  },
  kind = "spell",
  atlas = "YGOPacks",
  pos = { x = 0, y = 0 },
  config = { extra = 3, choose = 1},
  cost = 4,
  order = 1,
  weight = 1,
  draw_hand = true,
  create_card = function(self, card)
    r = pseudorandom('ygo_spellpack')
    if r < 0.1 then
        return create_card("spell_rare", G.pack_cards, nil, nil, true, true, nil, nil)
    else
        return create_card("spell", G.pack_cards, nil, nil, true, true, nil, nil)
    end
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_ygo_spell_pack",
}