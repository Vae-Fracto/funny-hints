Hooks:PostHook(PlayerMovement, "on_SPOOCed", "on_SPOOCed_FH", function(self)
    if self._current_state_name == "incapacitated" then
        FH.show_networked_hint(json.encode({ id = "downed_SPOOCed" }))
    end
end)
Hooks:PostHook(PlayerTased, "clbk_exit_to_fatal", "clbk_exit_to_fatal_FH", function()
    FH.show_networked_hint(json.encode({ id = "downed_tased" }))
end)
