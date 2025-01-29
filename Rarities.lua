SMODS.Rarity {
    key = 'ultra_rare',
    loc_txt = {
        name = 'Ultra Rare'
    },
    badge_colour = HEX('ffd700'),
    default_weight = 0.001, -- 1/1000
    pools = {
        ["Joker"] = true
        -- ["Joker"] = { rate = 0.005 },
    }
}

SMODS.Rarity {
    key = 'egyptian_god',
    loc_txt = {
        name = 'Egyptian God'
    },
    badge_colour = HEX('958d6b'),
    default_weight = 0.0005, -- 5/10000 (1/2000)
    pools = {
        ["Joker"] = true
        -- ["Joker"] = { rate = 0.005 },
    }
}
