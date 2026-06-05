Hooks:PostHook(GamePlayCentralManager, "stop_the_game", "stop_the_game_FH", function()
	if FH.sequences.playing then
		FH.stop_sequence(FH.sequences.playing.id, FH.sequences.playing.key)
	end
end)
