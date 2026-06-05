Hooks:PostHook(IngameWaitingForPlayersState, "at_exit", "at_exit_FH", function(self)
    if FH.log_file then
        DelayedCalls:Add("test_sequence_FH", 3, function()
            --FH.start_sequence("hud_gage_assignment_progress_common", "gage_pizzalawsuit")
        end)
    end

    local level_id = FH.shared_ids.level[Global.game_settings.level_id] or Global.game_settings.level_id
    FH.log("Level ID: " .. level_id)
    local heist_specific = FH.heist_specific[level_id]
    if heist_specific then
        if heist_specific.override then
            for id, messages in pairs(heist_specific.override) do
                FH.messages[id] = messages
            end
        end
        if heist_specific.insert then
            for id, messages in pairs(heist_specific.insert) do
                for index, message in ipairs(messages) do
                    table.insert(FH.messages[id], message)
                end
            end
        end
        if heist_specific.remove then
            for id, messages in pairs(FH.messages) do
                for remove_id, remove_message in pairs(heist_specific.remove) do
                    if id == remove_id then
                        for index, message in ipairs(messages) do
                            if message == remove_message then
                                table.delete(FH.messages[id], index)
                            end
                        end
                    end
                end
            end
        end
    end

    -- Setup weight sync
    for hint_id, messages in pairs(FH.messages) do
        for index, message in ipairs(messages) do
            if message ~= "$sequence;" then
                for hint_id_compare, messages_compare in pairs(FH.messages) do
                    if hint_id ~= hint_id_compare then
                        for index, message_compare in ipairs(messages_compare) do
                            if message == message_compare then
                                if not FH.duplicate_messages[message] then
                                    FH.duplicate_messages[message] = {}
                                end
                                FH.duplicate_messages[message][hint_id] = true
                                FH.duplicate_messages[message][hint_id_compare] = true
                            end
                        end
                    end
                end
            end
        end
    end

    local is_testing_map = level_id == "testing_map"
    local hint_id = "welcome_" .. level_id
    if not Global.FH.weights.welcome_modifier then
        Global.FH.weights.welcome_modifier = {}
    end
    if FH.messages[hint_id] and #FH.messages[hint_id] > 0 then
        local modifier = Global.FH.weights.welcome_modifier[hint_id] or 0
        local chance = #FH.messages[hint_id] / 20 + modifier
        if is_testing_map then
            chance = 0.05
        end
        --LogPrivateChat("Welcome hint chance is " .. chance * 100 .. "%. Modifier: +" .. modifier * 100 .. "%.")
        if math.random() < chance then
            --LogPrivateChat("Showing welcome hint...")
            DelayedCalls:Add("welcome_hint_FH", 5, function()
                FH.show_hint(hint_id)
            end)
            Global.FH.weights.welcome_modifier[hint_id] = 0
        elseif not is_testing_map then
            local function increase_modifier()
                Global.FH.weights.welcome_modifier[hint_id] = modifier + 0.075
                modifier = Global.FH.weights.welcome_modifier[hint_id]
                --LogPrivateChat("Inceased modifier to " .. modifier * 100 .. "%.")
            end
            DelayedCalls:Add("welcome_hint_modifier1_FH", 240, function()
                increase_modifier()
            end)
            DelayedCalls:Add("welcome_hint_modifier2_FH", 1200, function()
                increase_modifier()
            end)
        end
    else
        --LogPrivateChat("This heist has no welcome hint messages.")
    end
end)
