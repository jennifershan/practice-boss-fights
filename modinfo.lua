-- Description
name = "practice-boss-fights"
description = "Menu with options for practicing boss fights best used in solo worlds."
author = ""
version = "1.0"
forumthread = ""

--icon_atlas = "modicon.xml"
--icon = "modicon.tex"

-- Compatibility
dst_compatible = true

api_version = 10

all_clients_require_mod = false

--Config
server_filter_tags = {name, author}

configuration_options =
{
	-- Starting Configuration
	{
		name = "",
		label = "Starting Configuration",
		hover = "",
		default = 0,
		options = {
			{description = "", data = 0},
		},
	},
	-- Ancient Fuelweaver
	{
		name = "start_fw",
		label = "Ancient Fuelweaver",
		hover = "Set whether you start with: shadow atrium, atrium key, 8 fossil fragments.",
		default = 0,
		options = {
			{description = "False", data = 0, hover = "Disabled"},
			{description = "True", data = 1, hover = "Enabled (default)"},
		},
        default = 1,
	},
	-- Antlion
	{
		name = "start_al",
		label = "Antlion",
		hover = "Set whether you start with: desert goggles.",
		options = {
			{description = "False", data = 0, hover = "Disabled"},
			{description = "True", data = 1, hover = "Enabled (default)"},
		},
		default = 1,
	},
	-- Crab King
	{
		name = "start_ck",
		label = "Crab King",
		hover = "Set whether you start with: Pearl's Pearl.",
		options = {
			{description = "False", data = 0, hover = "Disabled"},
			{description = "True", data = 1, hover = "Enabled (default)"},
		},
		default = 1,
	},
	-- Eye of Terror
	{
        name = "start_eot",
		label = "Eye of Terror",
		hover = "Set whether you start with: Terrarium.",
		options = {
			{description = "False", data = 0, hover = "Disabled"},
			{description = "True", data = 1, hover = "Enabled (default)"},
		},
		default = 1,
    },
	-- Misery Toadstool
    {
        name = "start_mt",
		label = "Misery Toadstool",
		hover = "Set whether you start with: poisoned canary.",
		options =	{
			{description = "False", data = 0, hover = "Disabled"},
			{description = "True", data = 1, hover = "Enabled (default)"},
		},
		default = 1,
    },
	-- The Twins
	{
        name = "start_tt",
		label = "The Twins",
		hover = "Set whether you start with: Terrarium.",
		options = {
			{description = "False", data = 0, hover = "Disabled"},
			{description = "True", data = 1, hover = "Enabled (default)"},
		},
		default = 1,
    }
}