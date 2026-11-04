Hooks:PreHook(PlayerStandard, "_interupt_action_interact", "_interupt_action_interact_FH", function(self, t, input, complete)
    if self._interact_params and self._interact_params.tweak_data and complete then
        --FH.log(self._interact_params.tweak_data)
    end
    if self._interact_params and self._interact_params.tweak_data == "revive" and complete then
        local local_peer = managers.network:session():local_peer()
        FH.units_reviving[local_peer:id()] = true
        --FH.log("Set " .. local_peer:id() .. " reviveing state to " .. tostring(true))
    end
end)