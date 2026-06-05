local tag_rules = {
    downed_dozer = { has = { "law", "tank" } },
    downed_cloaker = { has = { "spooc" } },
    downed_taser = { has = { "taser" } },
    downed_medic = { has = { "medic" }, lacks = { "tank" } },
    downed_sniper = { has = { "sniper" } },
    downed_marshalstun = { has = { "law", "special" }, lacks = { "medic", "sniper", "marksman", "shield", "tank", "spooc", "taser" } },
}

local was_down = nil
local pre_state = nil
Hooks:PreHook(PlayerDamage, "_calc_health_damage", "_calc_health_damage_FH_pre", function(self, attack_data)
    was_down = FH.player_is_down()
    pre_state = self._unit:movement():current_state_name()
end)

Hooks:PostHook(PlayerDamage, "_calc_health_damage", "_calc_health_damage_FH_post", function(self, attack_data)
    if not self._unit:alive() then
        return
    end

    local is_down = FH.player_is_down()
    if not was_down and is_down and Application:digest_value(self._revives, false) > 0 then
        if pre_state == "tased" then
            FH.show_networked_hint(json.encode({ id = "downed_tased_assist" }))
            return
        end

        local unit = attack_data.attacker_unit
        if not unit or not unit:alive() then
            --LogPrivateChat("ERROR: Downed by an invalid unit: " .. tostring(unit))
            return
        end
        local unit_base = unit.base and unit:base()
        local unit_name = unit_base.char_tweak_name and unit_base:char_tweak_name()
        local unit_type = unit_base.get_type and unit_base:get_type()
        local attacker_name = unit_name or unit_type

        if attacker_name == "phalanx_minion" and Global.game_settings.gamemode == "crime_spree" then
            attacker_name = "phalanx_crime_spree"
        end

        if unit_name and unit_type then
            FH.log("Downed by a " .. unit_type .. " named " .. unit_name)
        else
            --FH.log("Downed by " .. tostring(attacker_name))
        end

        if unit_base._tags and not (attacker_name and FH.messages["downed_" .. attacker_name]) then
            for id, rules in pairs(tag_rules) do
                if unit_base:has_all_tags(rules.has) and (not rules.lacks or not unit_base:has_any_tag(rules.lacks)) then
                    FH.show_networked_hint(json.encode({ id = id }))
                    break
                end
            end
        elseif managers.hud._hud_assault_corner._assault_mode == "phalanx" and (attacker_name == "phalanx_minion" or attacker_name == "phalanx_vip") then
            FH.show_networked_hint(json.encode({ id = "downed_phalanx_formation" }))
        elseif attacker_name then
            FH.show_networked_hint(json.encode({ id = "downed_" .. attacker_name }))
        else
            FH.show_networked_hint(json.encode({ id = "downed_generic" }))
        end
    end
end)

Hooks:PreHook(PlayerDamage, "damage_fall", "damage_fall_FH_pre", function(self)
    was_down = FH.player_is_down()
end)

Hooks:PostHook(PlayerDamage, "damage_fall", "damage_fall_FH_post", function(self)
    if not self._unit:alive() then
        return
    end

    local is_down = FH.player_is_down()
    if not was_down and is_down then
        FH.show_networked_hint(json.encode({ id = "downed_fall_damage" }))
    end
end)

Hooks:PostHook(PlayerDamage, "_check_bleed_out", "_check_bleed_out_FH", function(self)
    FH.revives = Application:digest_value(self._revives, false) -- Track revives for "last life to custody" and medbag hints
end)

local fak_wasted = false
Hooks:PreHook(PlayerDamage, "band_aid_health", "band_aid_health_FH", function(self)
    if self._unit:_max_health() == self._unit:get_real_health() then
        if not fak_wasted then
            FH.show_hint("replenished_nothing_1")
            fak_wasted = true
        else
            FH.show_hint("replenished_nothing_2")
        end
    end
end)
