Hooks:PostHook(MissionEndState, "at_enter", "at_enter_FH", function()
	if FH.sequences.playing then
		FH.stop_sequence(FH.sequences.playing.id, FH.sequences.playing.key)
	end
end)
