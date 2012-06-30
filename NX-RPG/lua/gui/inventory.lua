--#textdomain wesnoth-NX-RPG
_ = wesnoth.textdomain "wesnoth-NX-RPG"

-- This brings up the custom inventory control window
function wml_actions.inventory_controller(cfg)
	local category_list = T.listbox { id = "category_list",
					  vertical_scrollbar_mode = "always",
					  T.list_definition { T.row { T.column { vertical_grow = "true", horizontal_grow = "true", grow_factor = 1,
										 T.toggle_panel { T.grid { T.row { T.column { T.image { id = "category_image", linked_group = "category_images" } },
														   T.column { T.label { id = "category_name", linked_group = "category_names" } },
														   T.column { T.spacer { definition = "default", width = 20 } } } } } } } } }

	local item_list = T.listbox { id = "inventory_list",
				      vertical_scrollbar_mode = "always",
				      T.header { T.row { T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5, 
								    T.label { id = "check_sort", linked_group = "checkbox", label = "" } },
							 T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5, 
							            T.label { id = "image_sort", linked_group = "image", label = "" } },
							 T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
								    T.button { id = "name_sort", linked_group = "name", label = "Name" } },
							 T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
								    T.label { id = "quantity_sort", linked_group = "quantity", label = "Quantity" } },
							 T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
							            T.label { id = "active_sort", linked_group = "active", label = "Active" } } } },
				      T.list_definition { T.row { T.column { vertical_grow = "true", horizontal_grow = "true",
									     T.toggle_panel { top_border = 20,
											      T.grid { T.row { T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
					  										  T.toggle_button { id = "list_checkbox",linked_group = "checkbox" } },
			       										       T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
					 										  T.image { id = "list_image", linked_group = "image" } },
													       T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
					  									          T.label { id = "list_name", definition = "title", linked_group = "name" } },
													       T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
															  T.label { id = "list_quantity", linked_group = "quantity" } },	
													       T.column { grow_factor = 1, horizontal_grow = "true", border = "all", border_size = 5,
															  T.label { id = "list_active", linked_group = "active", label = "yes" } } } } } } } } }

	local item_list_pages = T.multi_page { id = "item_list_pages",
					      vertical_scrollbar_mode = "always",
					      T.page_definition { T.row { grow_factor = 1, T.column { vertical_grow = "true", horizontal_grow = "true", item_list } } },
					      T.page_data { T.row { grow_factor = 1, T.column { item_list } } } }

	local instructions = T.label { wrap = "true",
				       label = _"Welcome to the inventory. Here you can view and manipulate all the items you are currently carrying, as well as those carried by allied units adjacent to you. Use the list to the left to choose whose inventory to see and manipulate, and use the checkboxes to the left of each item to select more than one at a time. You can mouse over the buttons for more info on their respective functions." }

	local main_window = { --maximum_height = 700,
			      --maximum_width = 800,
			      maximum_height = 900,
		     	      maximum_width = 1000,
			      T.helptip { id = "tooltip_large" }, -- mandatory field										
			      T.tooltip { id = "tooltip_large" }, -- mandatory field
			      T.linked_group { id = "category_images",
					       fixed_width = "true" },
			      T.linked_group { id = "category_names",
					       fixed_width = "true" },
			      T.linked_group { id = "image",
					       fixed_width = "true" },
			      T.linked_group { id = "checkbox",
				    	       fixed_height = "true",
					       fixed_width = "true" },
			      T.linked_group { id = "name",
					       fixed_width = "true" },
			      T.linked_group { id = "quantity",
					       fixed_width = "true" },
			      T.linked_group { id = "active",
					       fixed_width = "true" },
			      T.grid { T.row { T.column { vertical_grow = "true", horizontal_grow = "true", category_list },
					       T.column { T.spacer { definition = "default", width = 15 } },
					       T.column { T.grid { T.row { grow_factor = 1,
					       				   T.column { grow_factor = 1,
										      border = "all", border_size = 5,
						          		              horizontal_alignment = "left",
							  			      T.label { definition = "title", font_style = "bold", label = _"Inventory" } } },
				       				   T.row { T.column { border = "all", border_size = 5, vertical_grow = "true", horizontal_grow = "true", instructions } },
				       				   T.row { grow_factor = 1,
					       				   T.column { vertical_grow = "true", horizontal_grow = "true",
							  		              T.grid { T.row { T.column { border = "all", border_size = 5, horizontal_alignment = "left", T.label { definition = "title", label = _"Items" } } },
								   			       T.row { T.column { border = "all", border_size = 10, horizontal_grow = "true",  item_list } } } } },
				       				   T.row { grow_factor = 1,
					       				   T.column { vertical_grow = "true",
					       		  			      horizontal_grow = "true",
							  			      T.grid { T.row { grow_factor = 1,
									   			       T.column { vertical_alignment = "center",
							  			      				  horizontal_alignment = "left",
							  			      				  T.image { id = "details_image", linked_group = "image", label = "icons/inventory/option.png" } },
					       				   			       T.column { grow_factor = 1,
														  border = "all", border_size = 5,
										      				  vertical_grow = "true",
										      				  T.grid { T.row { grow_factor = 1,
												       				   T.column { grow_factor = 1, vertical_grow = "true", horizontal_alignment = "left",
														  		   	      T.label { definition = "title", id = "details_name" } } },
											       				   T.row { grow_factor = 1,
												      				   T.column { grow_factor = 1, vertical_grow = "true", horizontal_alignment = "left",
														  		   	      T.scroll_label { id = "details_description" } } } } },
					       				  			       T.column { grow_factor = 1,
							  			      				  horizontal_alignment = "right",
										      				  T.grid { T.row { T.column { border = "all", border_size = 5,
																	      T.button { id = "use_button", return_value = 4, label = _"Use Items",
																			 tooltip = _"Apply the currently selected items' effects to the current unit and any other applicable units" } } },
											       				   T.row { T.column { border = "all", border_size = 5,
																	      T.button { id = "give_take_button", return_value = 3, label = _"Give Items",
																			 tooltip = _"Move the currently selected items the appropriate inventories" } } },
															   T.row { T.column { border = "all", border_size = 5,
																	      T.button { id = "leave_chest_button", return_value = 2, label = _"Drop Items",
																			 tooltip = _"Drop the currently selected items. This will remove them from the any applicable inventories and place them in a chest for your allies to pick up" } } },
								   		               				   T.row { T.column { border = "all", border_size = 5,
																	      T.button { id = "ok_button", return_value = 1, label = _"Exit",
																			 tooltip = _"Exit the inventory and resume regular gameplay" } } } } } } } } } } } } } }

	local function inventory_preshow()
		--Category list

		local which_category_belongs_to_what_unit = {}

		--Category for the main unit
		wesnoth.set_dialog_value("items/ball-blue.png", "category_list", 1, "category_image")
		wesnoth.set_dialog_value("Your Items", "category_list", 1, "category_name")
		
		table.insert(which_category_belongs_to_what_unit, { id = wesnoth.get_variable("unit.id") } )

		--Generates other categories for adjacent allied hero units
		local current_category_index = 2
		for i = 1, wesnoth.get_variable("units_adjacent_to_unit_using_inventory.length") do
			local current_id = wesnoth.get_variable(string.format("%s[%d].id", "units_adjacent_to_unit_using_inventory", i - 1 ))

			wesnoth.set_dialog_value("items/ball-magenta.png", "category_list", current_category_index, "category_image")
			wesnoth.set_dialog_value(string.format("%s%s", current_id, "'s Items"), "category_list", current_category_index, "category_name")

			--wesnoth.set_variable(string.format("categorty_list_asignment[%d].id", current_category_index ), current_id)
			table.insert(which_category_belongs_to_what_unit, { id = current_id } )

			current_category_index = current_category_index + 1
		end

		-- Prints item list. Kept in a function because it will need to be called later again.
		local u_id = wesnoth.get_variable("unit.id")
		--local prev_max_list_index = 0
		local inv_list_data = {}
		local function print_item_list()
			inv_list_data = {}
			local var = string.format("%s.%s", u_id, "inventory")
			-- Deposit stuff in a table first for easy use later
			for i = 1, wesnoth.get_variable(var .. ".length") do
				table.insert(inv_list_data, { image = wesnoth.get_variable(string.format("%s[%d].image", var, i - 1)), 
						              name = wesnoth.get_variable(string.format("%s[%d].name", var, i - 1)),
						              description = wesnoth.get_variable(string.format("%s[%d].description", var, i - 1)),
						              quantity = wesnoth.get_variable(string.format("%s[%d].quantity", var, i - 1)) })
			end

			-- And print options from that
			for i = 1, #inv_list_data do
				wesnoth.set_dialog_value(inv_list_data[i].image, "inventory_list", i, "list_image")
				wesnoth.set_dialog_value(inv_list_data[i].name, "inventory_list", i, "list_name")
				wesnoth.set_dialog_value(inv_list_data[i].quantity, "inventory_list", i, "list_quantity")
			end

			-- Commented out for now, until necessary functions are introduced to mainline
			--max_list_index = #inv_list_data
			--if max_list_index < prev_max_list_index then
			--	for i = max_list_index + 1, prev_max_list_index do
			--		wesnoth.set_dialog_value("", "inventory_list", i, "list_image")
			--		wesnoth.set_dialog_value("", "inventory_list", i, "list_name")
			--		wesnoth.set_dialog_value("", "inventory_list", i, "list_quantity")
			--		wesnoth.set_dialog_value("", "inventory_list", i, "list_active")
			--	end
			--end
			-- Refresh var value
			--prev_max_list_index = max_list_index
		end

		-- Sets values for the details panel widgets
		local function select_from_inventory(list, data)
			local i = wesnoth.get_dialog_value(list)

			wesnoth.set_dialog_value(data[i].image, "details_image")
			wesnoth.set_dialog_value(data[i].name, "details_name")
			wesnoth.set_dialog_value(data[i].description, "details_description")
			-- insert any other things that need to be updated here
		end

		-- Used to sort the items by category as GUI2 listbox sorting doesn't exist yet :P
		local function sort_inventory_by_category(list, data, category)
			for i = 1, #data do
				data[i].checked = wesnoth.get_dialog_value(list, i, "list_checkbox")
			end
			table.sort(data, function(a, b) return a[category] < b[category] end)
			for i = 1, #data do
				wesnoth.set_dialog_value(data[i].image, list, i, "list_image")
				wesnoth.set_dialog_value(data[i].name, list, i, "list_name")
				wesnoth.set_dialog_value(data[i].checked, list, i, "list_checkbox")
			end
		end

		-- Sets the Give/Take button's value based on category selection
		local function select_category_effect()
			local category = wesnoth.get_dialog_value("category_list")
			-- Set button value
			if category == 1 then
				wesnoth.set_dialog_value("Give Items", "give_take_button")
			else
				wesnoth.set_dialog_value("Take Items", "give_take_button")
			end
			-- Refresh item list
			print_item_list()
		end

		-- Sets the callbacks to actually make stuff do stuff
		wesnoth.set_dialog_callback(function() select_category_effect() end, "category_list")
		wesnoth.set_dialog_callback(function() select_from_inventory("inventory_list", inv_list_data) end, "inventory_list")
		wesnoth.set_dialog_callback(function() sort_inventory_by_category("inventory_list", inv_list_data, "name") end, "name_sort")

		-- Actual call to the print function
		print_item_list()

		local function double_click_item()
		end

		--wesnoth.set_callback_mouse_left_double_click(function() double_click_item() end, "inventory_list_personal")
		--wesnoth.set_callback_mouse_left_double_click(function() double_click_item() end, "inventory_list_shared")
	end

	local function sync()
		local function inventory_postshow()
		end

		local return_value = wesnoth.show_dialog( main_window, inventory_preshow, inventory_postshow )

		return { return_value = return_value }
	end

	local return_table = wesnoth.synchronize_choice(sync)
end