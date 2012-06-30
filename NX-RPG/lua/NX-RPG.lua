--#textdomain wesnoth-NX-RPG
_ = wesnoth.textdomain "wesnoth-NX-RPG"

wml_actions = wesnoth.wml_actions
helper = wesnoth.require "lua/helper.lua"
T = helper.set_wml_tag_metatable {}

---
-- Removes the terrain overlay from every hex matching a given SLF.
--
-- [remove_terrain_overlays]
--     ... SLF ...
-- [/remove_terrain_overlays]
---
function wml_actions.remove_terrain_overlays(cfg)
	local locs = wesnoth.get_locations(cfg)

	for i, loc in ipairs(locs) do
		local locstr = wesnoth.get_terrain(loc[1], loc[2])
		wesnoth.set_terrain(loc[1], loc[2], string.gsub(locstr, "%^.*$", ""))
	end
end

---
-- Checks every unit matching the SUF's inventory for an certain item and executes some code
-- if it is found
--
-- [check_inventory]
--     [filter][/filter]
--     item=id
--     [then][/then]
-- [/check_inventory]
---
function wml_actions.check_inventory(cfg)
	local filter = helper.get_child(cfg, "filter") or
		helper.wml_error "[check_inventory] missing required [filter] tag"
	filter.role = "hero"
	local units = wesnoth.get_units(filter)

	for i, u in ipairs(units) do
		local u_id = units[i].id
		local items_carried = helper.get_variable_array(string.format("%s.%s", u_id, "inventory"))

		for ii,k in ipairs(items_carried) do
			if items_carried[ii].id == cfg.item then
				local stuff_to_do = helper.get_child(cfg, "then") or
					helper.wml_error "[check_inventory] missing required [then] tag"
				wesnoth.fire(stuff_to_do.__literal)
				return
			end
		end
	end
end

---
-- Adds a gui indicator like those for slow and poison to the displayed unit
--
-- [add_status_icon]
--     image=image
--     tooltip= _ "text"
-- [/add_status_icon]
---
function wml_actions.add_status_icon(cfg)
		local old_unit_status = wesnoth.theme_items.unit_status
	
		function wesnoth.theme_items.unit_status()
			local u = wesnoth.get_displayed_unit()
			if not u then return {} end

			local s = old_unit_status()
			if u.status.cfg.status then
				table.insert(s, { "element", {
					image = cfg.image,
					tooltip = _cfg.tooltip
				} })
			end
		end
		return s
	end
