if not Global.FH.abandoned then
    if not Global.FH.show_hint_stored then
        Global.FH.show_hint_stored = HUDManager.show_hint
    else
        HUDManager.show_hint = Global.FH.show_hint_stored
    end
else
    HUDManager.show_hint = function(_) end
end

local function set_message_weight(last_hint)
    if FH.hints_are_blocked() then
        return
    end

    local id = last_hint.id
    local text = last_hint.text
    local messages = FH.messages[id]

    if #messages > 1 then
        Global.FH.weights[id][text] = 0
        FH.sync_weight_on_duplicates(text, 0)
        --FH.log("Weight set in HudManager.")
    end
end

local function get_id_from_text(text)
    if text then
        for id, _ in pairs(FH.hints_without_id) do
            if managers.localization:text(id) == text then
                return id
            end
        end
    end
end

Hooks:PreHook(HUDManager, "show_hint", "show_hint_FH", function(self, params)
    local id = get_id_from_text(params.text)
    if id then
        params.text = FH.select_hint(id)
        if not params.text then
            return -- FH.select_hint will return nil if a sequence started from it
        end
    end
    if FH.last_hint and Application:time() == FH.last_hint.time then
        set_message_weight(FH.last_hint)
    else
        if FH.log_file and not FH.hints_are_blocked() then
            if not FH.log_file.missed_hints then
                FH.log_file.missed_hints = {}
            end
            local hint_already_logged = false
            for index, message in ipairs(FH.log_file.missed_hints) do
                if message == params.text then
                    hint_already_logged = true
                    break
                end
            end
            if not hint_already_logged then
                table.insert(FH.log_file.missed_hints, params.text)
                io.save_as_json(FH.log_file, FH.dev_path)
                FH.log("No replacement messages found. Added hint to LogFile.")
            end
        end
    end
end)

Hooks:PreHook(HUDManager, "present_mid_text", "present_mid_text_FH", function(self, params)
    local id = get_id_from_text(params.title)
    if id then
        FH.show_hint(id)
    end
end)

Hooks:PreHook(HUDManager, "set_mugshot_tased", "set_mugshot_tased_FH", function(self, id)
    if FH.chaos_conflict("ChaosModifierTase") or FH.chaos_conflict("ChaosModifierElectricBullets") then
        return
    end

    local name = "ERROR"
    local data = self:_get_mugshot_data(id)
    if data.peer_id then
        name = FH.get_unit_name(data.peer_id)
    elseif data.character_name_id then
        name = FH.get_unit_name(data.character_name_id, true)
    end
    FH.show_hint("teammate_electrocuted", { { pattern = "$TEAMMATE;", text = name } })
end)

Hooks:PreHook(HUDManager, "teammate_progress", "teammate_progress_FH", function(self, peer_id, type_index, enabled, tweak_data_id, timer, success)
    if tweak_data_id == "revive" and success then
        FH.units_reviving[peer_id] = true
        --FH.log("Set " .. peer_id .. " reviveing state to " .. tostring(true))
    end
end)