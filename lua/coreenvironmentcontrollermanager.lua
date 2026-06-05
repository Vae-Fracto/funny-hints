Hooks:PostHook(CoreEnvironmentControllerManager, "set_flashbang", "set_flashbang_FH", function(self)
    local flash_strength = math.pow(math.min(self._current_flashbang, 1), 16) + math.min(self._current_flashbang_flash, 1)
    if flash_strength >= 2 and not FH.player_is_down() then -- flash_strength 2 is max
        FH.show_hint("flash")
    end
end)