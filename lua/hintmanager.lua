local skip_hint = false
Hooks:PreHook(HintManager, "_show_hint", "_show_hint_FH_pre", function(self, hint_id, time, params)
	local id = Global.hint_manager.hints[hint_id].text_id
	local user_responsible = FH.hint_disabled_on[id]
	if user_responsible == "LOCAL" then
		skip_hint = true
	elseif user_responsible then
		for peer_id, boolean in pairs(FH.clients) do
			if FH.get_unit_name(peer_id) == params[user_responsible] then
				skip_hint = true
			end
		end
	end
	if skip_hint then
		managers.hud.show_hint = function(_) end
		--FH.log("Prevented local hint: " .. id)
		return
	end

	local message = nil

	if FH.shared_ids.hint[id] and #FH.shared_ids.hint[id] > 0 then
		message = FH.select_hint(FH.shared_ids.hint[id])
	elseif FH.messages[id] and #FH.messages[id] > 0 then
		message = FH.select_hint(id)
	else
		return
	end
	if not message then
		return -- FH.select_hint will return nil if a sequence started from it
	end
	LocalizationManager:add_localized_strings({
		[id] = message
	})
end)
Hooks:PostHook(HintManager, "_show_hint", "_show_hint_FH_post", function(self, hint_id, time, params)
	if skip_hint then
		managers.hud.show_hint = Global.FH.show_hint_stored
		skip_hint = false
	end
end)
