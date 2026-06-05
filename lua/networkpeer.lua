local non_clients = {}
Hooks:PostHook(NetworkPeer, "set_unit", "set_unit_FH", function(self, unit, character_name, team_id, visual_seed)
    FH.log("set_unit called")
    local local_peer = managers.network:session():local_peer()
    local peer_id = self._id
    if peer_id == local_peer:id() then
        return
    end

    local peer_name = FH.get_unit_name(peer_id)

    if not FH.clients[peer_id] and not non_clients[peer_id] then
        NetworkHelper:SendToPeer(peer_id, "handshake_request_FH", "")
        FH.log("Sending handshake request to " .. peer_name)
    end

    DelayedCalls:Add(peer_id .. "_handshake_timeout_FH", 3, function()
        if not FH.clients[peer_id] and not non_clients[peer_id] then
            FH.log("Recieved no response from " .. peer_name)
            local peer = managers.network:session():peer(peer_id)
            if FH.options.mark_non_users and peer then
                FH.mark_player(peer_id, "Not Funny")
            end
            non_clients[peer_id] = true
        end
    end)
end)

Hooks:PreHook(NetworkPeer, "destroy", "destroy_FH", function(self)
    local peer_id = self._id
    if FH.clients[peer_id] then
        FH.log("Unregistered client.")
        FH.clients[peer_id] = nil
    elseif non_clients[peer_id] then
        FH.log("Unregistered non-client.")
        non_clients[peer_id] = nil
    end
end)
