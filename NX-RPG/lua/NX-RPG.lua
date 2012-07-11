--#textdomain wesnoth-NX-RPG
_ = wesnoth.textdomain "wesnoth-NX-RPG"

wml_actions = wesnoth.wml_actions
--debug_utils = wesnoth.require '~add-ons/Wesnoth_Lua_Pack/debug_utils.lua' 
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
-- Checks every unit matching the SUF's inventory for an certain item and executes some
-- code if it is found. If no [filter] is found, the filter will be 'id=$unit.id'
--
-- [check_inventory]
--     [filter][/filter]
--     item=id
--     [then][/then]
-- [/check_inventory]
---
function wml_actions.check_inventory(cfg)
	local filter = helper.literal(helper.get_child(cfg, "filter"))
	if not filter then filter = wesnoth.tovconfig({id = "$unit.id"}) end
	filter.role = "hero"
	local units = wesnoth.get_units(filter)

	for i, u in ipairs(units) do
		local u_id = units[i].id
		local items_carried = helper.get_variable_array(string.format("%s.%s", u_id, "inventory"))

		for ii,k in ipairs(items_carried) do
			if items_carried[ii].id == cfg.item then
				local stuff_to_do = helper.get_child(cfg, "then")
				if not stuff_to_do then
					wesnoth.set_variable(string.format("%s%s", "has_", cfg.item), "true")
					return
				else
					wesnoth.fire(stuff_to_do.__literal)
					return
				end
			end
		end
	end
end

---
-- Adds a gui indicator like those for slow and poison to the displayed unit. The first
-- function is and internal lua one, the second is the wml_actions frontend.
--
-- [add_status_icon]
--     image=image
--     tooltip= _ "text"
--     status=status_name
-- [/add_status_icon]
---
function add_status_icon(image, tooltip, status)
	local old_unit_status = wesnoth.theme_items.unit_status

	function wesnoth.theme_items.unit_status()
		local u = wesnoth.get_displayed_unit()
		if not u then return {} end

		local s = old_unit_status()
		if u.status.status then
			table.insert(s, { "element", {
				image = image,
				tooltip = tooltip
			} })
		end
	end
	return s
end

-- WML frontend
function wml_actions.add_status_icon(cfg)
	add_status_icon(cfg.image, cfg.tooltip, cfg.status)
end

---
-- Installs mechanical, unlocked "Gate" units on *^Ng\ and *^Ng/ hexes using the given
-- owner side.
--
-- [setup_gates]
--     side=3
-- [/setup_gates]
---
function wml_actions.setup_gates(cfg)
	local locs = wesnoth.get_locations {
		terrain = "*^Ng\\",
		{ "or", { terrain = "*^Ng/" } },
		{ "not", { { "filter", {} } } },
	}

	for k, loc in ipairs(locs) do
		wesnoth.put_unit(loc[1], loc[2], {
			type = "Gate",
			side = cfg.side,
			id = string.format("__gate_X%dY%d", loc[1], loc[2]),
		})
	end
end

---
-- Installs mechanical "Gate" units on the given x,y coords using the given owner side.
-- If none are found, they will be placed on all *^Ngl\ and *^Ngl/ hexes instead.
--
-- [unlock_gates]
--     side=3
--     x,y=33,9
-- [/unlock_gates]
---
function wml_actions.unlock_gates(cfg)
	if cfg.x or cfg.y then
		local locs = wesnoth.get_locations {
			x = cfg.x,
			y = cfg.y,
			{ "not", { { "filter", {} } } },
		}
	else
		local locs = wesnoth.get_locations {
			terrain = "*^Ng\\",
			{ "or", { terrain = "*^Ng/" } },
			{ "not", { { "filter", {} } } },
		}
	end

	for k, loc in ipairs(locs) do
		wesnoth.put_unit(loc[1], loc[2], {
			type = "Gate",
			side = cfg.side,
			id = string.format("__locked_gate_X%dY%d", loc[1], loc[2]),
		})
	end
end
