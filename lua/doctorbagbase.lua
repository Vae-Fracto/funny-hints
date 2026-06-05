local insult = 0
local revives_used = 0
local medbag_wasted = false
local function set_values_insult(max_revives, misplay)
    if misplay then
        FH.misplays = FH.misplays + 1
    end
    insult = insult + 1
    revives_used = revives_used - max_revives
end
Hooks:PreHook(DoctorBagBase, "_take", "_take_FH", function(self, unit)
    local taker = unit:character_damage()
    local max_revives = taker._lives_init + managers.player:upgrade_value("player", "additional_lives", 0)
    local current_revives = FH.revives or max_revives
    local revives_replenished = max_revives - current_revives

    revives_used = revives_used + revives_replenished
    local recovered_max_revives = (revives_used + revives_replenished) >= (max_revives - 1) --you count as having 1 revive when on 0 lives

    if FH.options.sequences and (insult > 2 or FH.misplays > 3) and recovered_max_revives and Global.game_settings.difficulty ~= "sm_wish" and not Global.game_settings.one_down then
        FH.start_sequence("abandoned")
        managers.hud.show_hint = function(_)end
        Global.FH.abandoned = true
    elseif (insult > 1 and (not FH.options.sequences or FH.misplays < 4)) and recovered_max_revives then
        FH.show_hint("replenished_insult_2")
        set_values_insult(max_revives, true)
    elseif (insult == 1 and (not FH.options.sequences or FH.misplays < 4)) and recovered_max_revives then
        FH.show_hint("replenished_insult_1")
        set_values_insult(max_revives, true)
    elseif revives_replenished == (max_revives - 1) or Global.game_settings.one_down then --you count as having 1 revive when on 0 lives
        FH.show_hint("replenished_last_life")
    elseif revives_replenished == 1 then
        FH.show_hint("replenished_got1life")
    elseif revives_replenished > 1 then
        FH.show_hint("replenished")
    elseif taker:_max_health() > taker:get_real_health() then
        FH.show_hint("replenished_health")
    else
        if not medbag_wasted then
            FH.show_hint("replenished_nothing_1")
            medbag_wasted = true
        else
            FH.show_hint("replenished_nothing_2")
        end
    end

    if insult == 0 and recovered_max_revives then
        set_values_insult(max_revives, false)
    end
end)
