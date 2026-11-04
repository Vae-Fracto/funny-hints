local function get_gsub_info(unit)
    local is_bot = false
    local peer = unit:network():peer()
    local id = nil
    if not peer then
        is_bot = true
        id = unit:base()._tweak_table
    else
        id = peer:id()
    end
    return id, is_bot
end

Hooks:PreHook(TradeManager, "sync_teammate_helped_hint", "sync_teammate_helped_hint_FH", function(self, target_unit, helper_unit, hint)
    if not alive(target_unit) or not alive(helper_unit) or hint ~= 2 then
        return
    end

    local local_player = managers.player:local_player()

    local helper_id, helper_is_bot = get_gsub_info(helper_unit)
    local target_id, target_is_bot = get_gsub_info(target_unit)
    local helper_name = FH.get_unit_name(helper_id, helper_is_bot)
    local target_name = FH.get_unit_name(target_id, target_is_bot)
    local helper_gsub = { pattern = "$HELPER;", text = helper_name }
    local target_gsub = { pattern = "$TEAMMATE;", text = target_name }

    if helper_unit == local_player then
        if target_is_bot then
            FH.show_hint("hint_you_helpedup", { target_gsub })
        elseif FH.units_reviving[helper_id] then
            FH.show_hint("hint_you_helpedup_touch", { target_gsub })
        else
            FH.show_hint("inspire", { target_gsub })
        end
    elseif target_unit == local_player then
        if helper_is_bot then
            FH.show_hint("hint_you_were_helpedup", { helper_gsub })
        elseif FH.units_reviving[helper_id] then
            FH.show_hint("hint_you_were_helpedup_touch", { helper_gsub })
        else
            FH.show_hint("inspire_received", { helper_gsub })
        end
    else
        if helper_is_bot or target_is_bot then
            FH.show_hint("hint_teammate_helpedup", { helper_gsub, target_gsub })
        elseif FH.units_reviving[helper_id] then
            FH.show_hint("hint_teammate_helpedup_touch", { helper_gsub, target_gsub })
        else
            FH.show_hint("inspire_teammate", { helper_gsub, target_gsub })
        end
    end

    if not helper_is_bot then
        FH.units_reviving[helper_id] = false
        --FH.log("Cleared " .. helper_id .. " reviveing state")
    end
end)
