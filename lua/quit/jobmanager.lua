Hooks:PostHook(JobManager, "deactivate_current_job", "deactivate_current_job_FH", function()
	if FH.sequences.playing then
		FH.stop_sequence(FH.sequences.playing.id, FH.sequences.playing.key)
	end
end)
