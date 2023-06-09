-- Setup global variables
local _g = GLOBAL
local require = _g.require

-- Obtain variables for component overrides
start_fw = GetModConfigData("start_fw")
start_al = GetModConfigData("start_al")
start_ck = GetModConfigData("start_ck")
start_eot = GetModConfigData("start_eot")
start_mt = GetModConfigData("start_mt")
start_tt = GetModConfigData("start_tt")

local craft = require "widgets/redux/craftingmenu_widget"
local PlayerHud = require "screens/playerhud"
AddSimPostInit(function()
	_g.TheInput:AddKeyHandler(
	function(key, down)
		if not down then return end
		if key == _g.KEY_P then
			local screen = TheFrontEnd:GetActiveScreen()
			if not screen or not screen.name then return true end
			-- If the hud exists, open the UI
			if screen.name:find("HUD") and _g.ThePlayer and _g.ThePlayer.components.playercontroller:IsEnabled()then
                -- We want to pass in the (clientside) player entity
				TheFrontEnd:PushScreen(require("menu")(_g.ThePlayer))
				return true
			else
				-- If the screen is already open, close it
				if screen.name == "menu" then
					screen:OnClose()
				end
			end
		end
		-- Require CTRL for any debug keybinds
		if _g.TheInput:IsKeyDown(_g.KEY_CTRL) then
			 -- Load latest save and run latest scripts
			if key == _g.KEY_R then
				if _g.TheWorld.ismastersim then
					_g.c_reset()
				else
					_g.TheNet:SendRemoteExecute("c_reset()")
				end
			end
		end
	end)
end)

local bosses = require "bosses"
local modName = _g.KnownModIndex:GetModActualName("practice-boss-fights")
AddModRPCHandler(modName, "MenuBosses", function(player, index)
	if index <= #bosses then
		_g.TheNet:Announce("Fighting " .. (bosses[index].name or "NIL") .. " activated by " .. (player.name or "NIL"))
		-- player.components.talker:Say("Fighting " .. (bosses[index].name or "NIL") .. " activated by " .. (player.name or "NIL"))
		bosses[index].activate(player)
	end
end)

local function GiveAllCrafting()
	for k,v in pairs(_g.AllPlayers) do
	  v.components.builder:GiveAllRecipes()
	end
end

AddPrefabPostInit("world", function(inst)
	inst:ListenForEvent("ms_playerjoined", function(inst, player)
		GiveAllCrafting()
	end)
end)