--#textdomain wesnoth-NX-RPG
_ = wesnoth.textdomain "wesnoth-NX-RPG"

---
-- Used to see if a character has been found and developed
--
-- [check_for_character]
--   ... Unit stats ...
-- [/check_for_character]
---
function wml_actions.check_for_character(cfg)
	if not wesnoth.eval_conditional( { { "have_unit", { side = 1, id = cfg.id } } } ) then
		wml_actions.unit(cfg)
	end

	if not wesnoth.get_variable(cfg.id .. ".class") then
		wesnoth.set_variable("char_devel_temp_id", cfg.id)
		wesnoth.fire_event("herodevel")
	end
end