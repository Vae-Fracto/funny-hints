local custody_visits = 0
Hooks:PreHook(PlayerManager, "on_enter_custody", "on_enter_custody_FH", function(self, _player, already_dead)
    if not already_dead then
        custody_visits = custody_visits + 1
        if custody_visits > 3 or FH.misplays > 3 then
            FH.show_hint("abandoned")
            Global.FH.abandoned = true
            managers.hud.show_hint = function(_) end
        elseif FH.revives == 0 then -- last life to custody
            FH.show_hint("custody_visit_last_life")
        else
            FH.show_hint("custody_visit")
        end
    end
    FH.misplays = FH.misplays + 1
end)
