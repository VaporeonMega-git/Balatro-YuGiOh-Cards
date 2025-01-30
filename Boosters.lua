SMODS.Booster {
  name = "Spell/Trap Pack",
  key = "spelltrap_normal_1",
  loc_txt = {
    name = 'Spell/Trap Pack',
    text = {
      "Choose {C:attention}1{} of up to",
      "{C:attention}3{} {C:planet}Spell{}/{C:tarot}Trap{} cards to",
      "be pulled or used immediately"
    }
  },
  kind = "spell",
  atlas = "YGOPacks",
  pos = {x=0, y=0},
  config = {extra = 3, choose = 1},
  cost = 4,
  order = 1,
  weight = 1,
  draw_hand = true,
  create_card = function(self, card)
    for k, v in ipairs(G.STATES) do
        print(v)
    end
    r1 = pseudorandom('ygo_spellpack')
    if r1 < 0.15 then
        -- r2 = pseudorandom('ygo_spellpack')
        -- if r2 < 0.1 then
        --     card = create_card("trap_rare", G.pack_cards, nil, nil, true, true, nil, nil)
        -- else
            card = create_card("trap", G.pack_cards, nil, nil, true, true, nil, nil)
        -- end
    end
    if r1 >= 0.15 or card.ability.name == "Joker" then
        r2 = pseudorandom('ygo_spellpack')
        if r2 < 0.1 then
            card = create_card("spell_rare", G.pack_cards, nil, nil, true, true, nil, nil)
        else
            card = create_card("spell", G.pack_cards, nil, nil, true, true, nil, nil)
        end
    end
    return card
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_ygo_spell_pack",
}

-- Code from Betmma's Vouchers
G.FUNCS.can_reserve_card = function(e)
    if #G.consumeables.cards < G.consumeables.config.card_limit then
        e.config.colour = G.C.GREEN
        e.config.button = "reserve_card"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

-- Code from Betmma's Vouchers
G.FUNCS.reserve_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
            c1.area:remove_card(c1)
            c1:add_to_deck()
            if c1.children.price then
                c1.children.price:remove()
            end
            c1.children.price = nil
            if c1.children.buy_button then
                c1.children.buy_button:remove()
            end
            c1.children.buy_button = nil
            remove_nils(c1.children)
            G.consumeables:emplace(c1)
            G.GAME.pack_choices = G.GAME.pack_choices - 1
            if G.GAME.pack_choices <= 0 then
                G.FUNCS.end_consumeable(nil, delay_fac)
            end
            return true
        end,
    }))
end

-- Code from Cryptid
local original_func = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
        if card.ability.set == "spell" or card.ability.set == "spell_rare" or card.ability.set == "trap" or card.ability.set == "trap_rare" then
            return {
                n = G.UIT.ROOT,
                config = { padding = -0.1, colour = G.C.CLEAR },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            ref_table = card,
                            r = 0.08,
                            padding = 0.1,
                            align = "bm",
                            minw = 0.5 * card.T.w - 0.15,
                            minh = 0.7 * card.T.h,
                            maxw = 0.7 * card.T.w - 0.15,
                            hover = true,
                            shadow = true,
                            colour = G.C.UI.BACKGROUND_INACTIVE,
                            one_press = true,
                            button = "use_card",
                            func = "can_reserve_card",
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "PULL",
                                    colour = G.C.UI.TEXT_LIGHT,
                                    scale = 0.55,
                                    shadow = true,
                                },
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            ref_table = card,
                            r = 0.08,
                            padding = 0.1,
                            align = "bm",
                            minw = 0.5 * card.T.w - 0.15,
                            maxw = 0.9 * card.T.w - 0.15,
                            minh = 0.1 * card.T.h,
                            hover = true,
                            shadow = true,
                            colour = G.C.UI.BACKGROUND_INACTIVE,
                            one_press = true,
                            button = "Do you know that this parameter does nothing?", -- Wow that's crazy
                            func = "can_use_consumeable",
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = localize("b_use"),
                                    colour = G.C.UI.TEXT_LIGHT,
                                    scale = 0.45,
                                    shadow = true,
                                },
                            },
                        },
                    },
                    { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                    { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                    { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                    { n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
                    -- Betmma can't explain it, neither can whoever originally left this comment
                    -- though, neither can I
                },
            }
        end
    end
    return original_func(card)
end
