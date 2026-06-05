Hooks:PreHook(UnitNetworkHandler, "long_dis_interaction", "long_dis_interaction_FH", function(self, target_unit, amount, aggressor_unit, secondary)
    if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(target_unit) or not self._verify_character(aggressor_unit) then
        return
    end

    if target_unit ~= managers.player:local_player() or amount ~= 0 then
        return
    end

    local peer = aggressor_unit:network() and aggressor_unit:network():peer()
    if not peer then
        return
    end

    if FH.player_is_down() then
        return
    end
    local message = FH.select_hint("call")
    if not message then
        return -- FH.select_hint will return nil if a sequence started from it
    end
    LocalizationManager:add_localized_strings({
        hint_follow_player = message,
        hint_uncuff_player = message,
        hint_help_player = message,
    })
end)
