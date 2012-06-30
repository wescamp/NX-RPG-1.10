--#textdomain wesnoth-NX-RPG
_ = wesnoth.textdomain "wesnoth-NX-RPG"

function wml_actions.show_nx_help(cfg)
	local topic_list = T.listbox { id = "topic_list",
				       T.header { T.row { T.column { T.label { definition = "title", label = _"Topics" } } } },
				       T.list_definition { T.row { T.column { vertical_grow = "true", horizontal_grow = "true", grow_factor = 1,
									      T.toggle_panel { T.grid { T.row { T.column { T.image { id = "topic_list_image", linked_group = "images", label = "icons/menu-book.png" } },
													        T.column { border = "all", border_size = 5,
															   T.label { id = "topic_list_name", linked_group = "names" } } } } } } } } }

	local main_window = { maximum_height = 1300,
		     	      maximum_width = 1000,
			      T.linked_group { id = "images",
					       fixed_width = "true" },
			      T.linked_group { id = "names",
					       fixed_width = "true" },
			      T.helptip { id = "tooltip_large" }, -- mandatory field
			      T.tooltip { id = "tooltip_large" }, -- mandatory field
			      T.grid { T.row { T.column { topic_list },
				               T.column { T.grid { T.row { T.column { T.label { id = "topic_name" } } },
								   T.row { T.column { T.scroll_label { id = "topic_text", wrap = "true" } } },
				       				   T.row { T.column { T.button { id = "close_button", return_value = 1, label = _"Close" } } } } } } } }

	local function help_preshow()
	end

	local function sync()
		local function help_postshow()
		end

		local return_value = wesnoth.show_dialog( main_window, help_preshow, help_postshow )

		return { return_value = return_value }
	end

	local return_table = wesnoth.synchronize_choice(sync)
end