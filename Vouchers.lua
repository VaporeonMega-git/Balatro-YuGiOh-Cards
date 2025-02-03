SMODS.Voucher {
    key = "joey_voucher",
    loc_txt = {
        name = "Joey's Voucher",
        text = {
            "{C:attention}Time Wizard{} hits",
            "{C:green}+25%{} of the time"
        }
    },
    atlas = "YGOVouchers",
    pos = {x=0, y=2},
    config = {extra = {a_odds_num = 25.0}},
    cost = 10,
    redeem = function(self, card, context)
        if not G.GAME.probabilities.time_wizard then
            G.GAME.probabilities.time_wizard = 0.0 -- addative
        end
        G.GAME.probabilities.time_wizard = G.GAME.probabilities.time_wizard + card.ability.extra.a_odds_num
    end
}

SMODS.Voucher {
    key = "joey_voucher_2",
    loc_txt = {
        name = "Plot Armor",
        text = {
            "{C:attention}Time Wizard{} hits",
            "{C:green}+20%{} of the time"
        }
    },
    atlas = "YGOVouchers",
    pos = {x=0, y=3},
    config = {extra = {a_odds_num = 20.0}},
    cost = 10,
    redeem = function(self, card, context)
        if not G.GAME.probabilities.time_wizard then
            G.GAME.probabilities.time_wizard = 0.0 -- addative
        end
        G.GAME.probabilities.time_wizard = G.GAME.probabilities.time_wizard + card.ability.extra.a_odds_num
    end
}
