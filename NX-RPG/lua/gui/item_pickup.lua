--#textdomain wesnoth-NX-RPG
_ = wesnoth.textdomain "wesnoth-NX-RPG"

--This dialogue pops up when you move to pick up an item
function wml_actions.pick_up_item(cfg)
	local item_dialog = { --definition = "message", --still not working...yet
			      T.helptip { id="tooltip_large" }, -- mandatory field
			      T.tooltip { id="tooltip_large" }, -- mandatory field
			      maximum_height = 320,
			      maximum_width = 480,
			      T.grid { -- Title, will be the object name
				      T.row { T.column { horizontal_alignment = "left",
							 grow_factor = 1,
							 border = "all",
							 border_size = 5,
							 T.label { definition = "title", id = "item_name" } } },
				      -- Image and item description
				      T.row { T.column { T.grid { T.row { T.column { vertical_alignment = "center",
								                     horizontal_alignment = "center",
										     border = "all",
								  		     border_size = 5,
								  		     T.image { id = "image_name" } },
						       			  T.column { horizontal_alignment = "left",
								 		     border = "all",
								  		     border_size = 5,
								  		     T.scroll_label { id = "item_description" } } } } } }, -- grid terminator
				      T.row { T.column { T.spacer { height = 10 } } },
				      -- button box
				      T.row { T.column { T.grid { T.row { T.column { T.button { id = "take_button", return_value = 1, label = _"Add To Inventory" } },
					      T.column { T.spacer { width = 10 } },
					      T.column { T.button { id = "leave_button", return_value = 2, label = _"Put Back Down" } } } } } } } }

	local function item_preshow()
		-- here set all widget starting values
		wesnoth.set_dialog_value ( cfg.name, "item_name" )
		wesnoth.set_dialog_value ( cfg.image or "", "image_name" )
		wesnoth.set_dialog_value ( cfg.description, "item_description" )
	end

	local function sync()
		local function item_postshow()
			-- here get all widget values
		end

		local return_value = wesnoth.show_dialog( item_dialog, item_preshow, item_postshow )

		return { return_value = return_value }
	end

	local return_table = wesnoth.synchronize_choice(sync)
	if return_table.return_value == 1 or return_table.return_value == -1 then
		local u_id = wesnoth.get_variable("unit.id") 
		local check_var = string.format("%s.%s", u_id, "inventory")

		for i = 1, wesnoth.get_variable(check_var .. ".length") do
			local current_item_being_checked_id = wesnoth.get_variable(string.format("%s[%d].id", check_var, i - 1))
			if current_item_being_checked_id == cfg.id then
				local has_item = "true"
				local current_quantity = wesnoth.get_variable(string.format("%s[%d].quantity", check_var, i - 1))
				wesnoth.set_variable(string.format("%s[%d].quantity", check_var, i - 1), current_quantity + 1)
			end
		end

		if not has_item then
			local i_index = wesnoth.get_variable(string.format("%s.%s.%s", u_id, "inventory", "length"))
			local var_path = string.format("%s.%s[%i]", u_id, "inventory", i_index)

			local item_action = helper.get_child(cfg, "command")
			local remove_action = helper.get_child(cfg, "remove_command")

			wesnoth.set_variable(var_path .. ".id", cfg.id)
			wesnoth.set_variable(var_path .. ".name", cfg.name)
			wesnoth.set_variable(var_path .. ".quantity", 1)
			wesnoth.set_variable(var_path .. ".image", cfg.image)
			wesnoth.set_variable(var_path .. ".description", cfg.description)
			wesnoth.set_variable(var_path .. ".command", item_action.__literal)
			wesnoth.set_variable(var_path .. ".remcommand", remove_action.__literal)

			wesnoth.fire_event(cfg.id)
		end
	end
end
