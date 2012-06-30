--#textdomain wesnoth-NX-RPG
_ = wesnoth.textdomain "wesnoth-NX-RPG"

-- This brings up the character development dialog
function wml_actions.develop_character(cfg)
	local class_list = T.listbox { id = "class_list",
				       T.header { T.row { T.column { T.label { definition = "title", label = _"Classes" } } } },
				       T.list_definition { T.row { T.column { vertical_grow = "true", horizontal_grow = "true", grow_factor = 1,
									      T.toggle_panel { T.grid { T.row { T.column { T.image { id = "class_image", linked_group = "list_images" } },
													        T.column { border = "all", border_size = 5,
															   T.label { id = "class_name", linked_group = "list_names" } } } } } } } } }

	local alignment_list = T.listbox { id = "alignment_list",
					   T.header { T.row { T.column { T.label { definition = "title", label = _"Alignments" } } } },
					   T.list_definition { T.row { T.column { vertical_grow = "true", horizontal_grow = "true", grow_factor = 1,
									          T.toggle_panel { T.grid { T.row { T.column { T.image { id = "alignment_image", linked_group = "list_images" } },
													            T.column { border = "all", border_size = 5,
															       T.label { id = "alignment_name", linked_group = "list_names" } } } } } } } } }

	local trait_list = T.listbox { id = "trait_list",
				       T.header { T.row { T.column { T.label { definition = "title", label = _"Traits" } } } },
				       T.list_definition { T.row { T.column { vertical_grow = "true", horizontal_grow = "true", grow_factor = 1,
									      T.toggle_panel { T.grid { T.row { T.column { T.image { id = "trait_image", linked_group = "list_images" } },
													        T.column { border = "all", border_size = 5,
															   T.label { id = "trait_name", linked_group = "list_names" } } } } } } } } }

	local instructions = T.label { wrap = "true",
				       label = _"Here you can choose a Class, Alignment, and Trait for the currently selected character. Select one option from each category. When you're satisfied, click Done. You cannot change your selections afterwards." }

	local main_window = { maximum_height = 500,
		     	      maximum_width = 800,
			      T.helptip { id = "tooltip_large" }, -- mandatory field
			      T.tooltip { id = "tooltip_large" }, -- mandatory field
			      T.linked_group { id = "list_images",
					       fixed_width = "true" },
			      T.linked_group { id = "list_names",
					       fixed_width = "true" },
			      T.linked_group { id = "image",
					       fixed_width = "true" },
			      T.grid { T.row { grow_factor = 1,
					       T.column { T.spacer { definition = "default" } },
					       T.column { border = "left, top, bottom", border_size = 5, horizontal_alignment = "left", T.label { definition = "title", label = "Character Development" } } },
				       T.row { T.column { T.spacer { definition = "default" } },
					       T.column { border = "left, right, bottom", border_size = 5, horizontal_grow = "true", instructions } },
				       T.row { grow_factor = 1,
					       T.column { T.spacer { definition = "default", height = 260 } },
					       T.column { horizontal_grow = "true", vertical_grow = "true",
							  T.grid { T.row { T.column { T.spacer { definition = "default", height = 260 } },
									   T.column { grow_factor = 1, border = "left, top, bottom", border_size = 5, horizontal_grow = "true", vertical_grow = "true", class_list },
									   T.column { grow_factor = 1, border = "all", border_size = 5, horizontal_grow = "true", vertical_grow = "true", alignment_list },
									   T.column { grow_factor = 1, border = "right, top, bottom", border_size = 5, horizontal_grow = "true", vertical_grow = "true", trait_list } } } } },
				       T.row { grow_factor = 1,
					       T.column { T.spacer { definition = "default" } },
					       T.column { border = "top", border_size = 5,
							  vertical_grow = "false",
					       		  horizontal_grow = "true",
							  T.grid { T.row { grow_factor = 1,
									   T.column { vertical_alignment = "center",
							  			      horizontal_alignment = "left",
							  			      T.image { id = "details_image", linked_group = "image", label = "attacks/staff-green.png" } },
					       				   T.column { grow_factor = 1,
										      border = "all", border_size = 5,
										      horizontal_grow = "true", vertical_grow = "false",
										      T.grid { T.row { grow_factor = 1,
												       T.column { vertical_grow = "true", horizontal_alignment = "left",
														  T.label { definition = "title", id = "details_name", label = "                 " } } },
											       T.row { grow_factor = 1,
												       T.column { vertical_grow = "false", horizontal_alignment = "left",
														  T.scroll_label { id = "details_description", label = " ", wrap = "true" } } } } },
					       				   T.column { grow_factor = 1,
							  			      horizontal_alignment = "right",
										      T.grid { T.row { T.column { border = "all", border_size = 5,
														  T.button { id = "done_button", return_value = 1, label = _"Done",
															     tooltip = _"Apply the currently selected options to the selected character and exit" } } },
											       T.row { T.column { T.button { id = "description-button", return_value = 2, label = _"Cancel",
															     tooltip = _"Exit and return to game without developing the selected character" } } } } } } } } } } }

	local function char_devel_preshow()
		local function nx.print_list(list, max_index)
			for i = 1, max_index do
				local name = wesnoth.get_variable(string.format("%s[%d].name", "character_development." .. list, i - 1))
				local image = wesnoth.get_variable(string.format("%s[%d].image", "character_development." .. list, i - 1))

				wesnoth.set_dialog_value(image, list .. "_list", i, list "_image")
				wesnoth.set_dialog_value(name, list .. "_list", i, list "_name")
			end
		end

		-- Prints out the lists
		nx.print_list("class", 6)
		nx.print_list("alignment", 4)
		nx.print_list("trait", 7)
				
		-- Sets values for the details panel widgets
		local function select_from_list(list)
			local i = wesnoth.get_dialog_value(string.format("%s_%s", list, "list"))
			local section = string.format("%s.%s", "character_development", list)
			
			wesnoth.set_dialog_value(wesnoth.get_variable(string.format("%s[%d].image", section, i - 1)), "details_image")
			wesnoth.set_dialog_value(wesnoth.get_variable(string.format("%s[%d].name", section, i - 1)), "details_name")		
			wesnoth.set_dialog_value(wesnoth.get_variable(string.format("%s[%d].description", section, i - 1)), "details_description")
			-- insert any other things that need to be updated here
		end

		-- Sets the user's choice
		local function click_done()
			local u_id = wesnoth.get_variable("unit.id")

			wesnoth.set_variable(string.format("%s%s", "character_developed_", u_id), "true")
			wesnoth.set_variable(string.format("%s.%s", u_id, "class"), wesnoth.get_variable(string.format("character_development.class[$d].id", wesnoth.get_dialog_value("class_list"))))
			wesnoth.set_variable(string.format("%s.%s", u_id, "alignment"), wesnoth.get_variable(string.format("character_development.alignment[$d].id", wesnoth.get_dialog_value("alignment_list"))))
			wesnoth.set_variable(string.format("%s.%s", u_id, "trait"), wesnoth.get_variable(string.format("character_development.trait[$d].id", wesnoth.get_dialog_value("trait_list"))))
			
		end

		-- Callbacks for each list
		wesnoth.set_dialog_callback(function() select_from_list("class") end, "class_list")
		wesnoth.set_dialog_callback(function() select_from_list("alignment") end, "alignment_list")
		wesnoth.set_dialog_callback(function() select_from_list("trait") end, "trait_list")

		wesnoth.set_dialog_callback(function() click_done() end, "done_button")
	end

	local function sync()
		local function char_devel_postshow()
		end

		local return_value = wesnoth.show_dialog( main_window, char_devel_preshow, char_devel_postshow )

		return { return_value = return_value }
	end

	local return_table = wesnoth.synchronize_choice(sync)
end