-- Code from Cryptid
SMODS.Tag {
    atlas = "YGOTags",
    loc_txt = {
        name = "Blue-Eyes Tag",
        text = {
            "A Blue-Eyes White Dragon",
            "appears in the next shop"
        }
    },
    pos = {x=0, y=0},
    config = { type = "store_joker_create" },
    key = "blue_eyes",
    apply = function(self, tag, context)
      if context.type == "store_joker_create" then
        local card = create_card("Joker", context.area, nil, nil, nil, nil, ('j_ygo_blue_eyes_white_dragon'))
        create_shop_card_ui(card, "Joker", context.area)
        card.states.visible = false
        tag:yep("+", G.C.FILTER, function()
          card:start_materialize()
          return true
        end)
        tag.triggered = true
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.5,
          func = function()
            save_run() --fixes savescum bugs hopefully?
            return true
          end,
        }))
        return card
      end
    end,
    in_pool = function()
      return false
    end
  }
