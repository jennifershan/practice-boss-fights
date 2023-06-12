local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Templates = require "widgets/templates"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local bosses = require "bosses"

local Menu = Class(Screen, function(self, inst)
  self.inst = inst
  self.tasks = {}

  Screen._ctor(self, "menu")
  
  self.black = self:AddChild(Image("images/global.xml", "square.tex"))
  self.black:SetVRegPoint(ANCHOR_MIDDLE)
  self.black:SetHRegPoint(ANCHOR_MIDDLE)
  self.black:SetVAnchor(ANCHOR_MIDDLE)
  self.black:SetHAnchor(ANCHOR_MIDDLE)
  self.black:SetScaleMode(SCALEMODE_FILLSCREEN)
  self.black:SetTint(0, 0, 0, .5)

  self.proot = self:AddChild(Widget("ROOT"))
  self.proot:SetVAnchor(ANCHOR_MIDDLE)
  self.proot:SetHAnchor(ANCHOR_MIDDLE)
  self.proot:SetPosition(20, 0, 0)
  self.proot:SetScaleMode(SCALEMODE_PROPORTIONAL)

  self.bg = self.proot:AddChild(Templates.CurlyWindow(500, 450, 1, 1, 68, -40))
  self.title = self.proot:AddChild(Text(NEWFONT_OUTLINE, 40, "Practice Boss Fights", {unpack(GOLD)}))
  self.title:SetPosition(0, 245)
  
  self.bosses = self.proot:AddChild(Widget("ROOT"))
  self.bosses:SetPosition(-100, 0)
  self.bosses.cards = {}

  self.ent_cave = self.proot:AddChild(ImageButton("minimap/minimap_data.xml", "cave_closed.png"))
  self.ent_cave:SetPosition(-163, -215)
  self.ent_cave:SetScale(0.8, 0.8)
  self.ent_cave:SetOnClick(function()
    c_remote("c_gonext('cave_entrance')")
    TheFrontEnd:GetActiveScreen():OnClose()
  end)

  self.ent_cave_open = self.proot:AddChild(ImageButton("minimap/minimap_data.xml", "cave_open.png"))
  self.ent_cave_open:SetPosition(-100, -215)
  self.ent_cave_open:SetOnClick(function()
    c_remote("c_gonext('cave_entrance_open')")
    TheFrontEnd:GetActiveScreen():OnClose()
  end)

  self.ex_cave = self.proot:AddChild(ImageButton("minimap/minimap_data.xml", "cave_open2.png"))
  self.ex_cave:SetPosition(115, -215)
  self.ex_cave:SetOnClick(function()
    c_remote("c_gonext('cave_exit')")
    TheFrontEnd:GetActiveScreen():OnClose()
  end)

  self.players_join = self.proot:AddChild(ImageButton("images/avatars.xml", "avatar_admin.tex"))
  self.players_join:SetPosition(410, -210)
  self.players_join:SetScale(0.6)
  self.players_join:AddChild(Text(NEWFONT_OUTLINE, 45, "Gather", {unpack(GOLD)}))
  self.players_join.text:SetPosition(0, -20)
  self.players_join:SetOnClick(function()
    c_remote([[local x, y, z = ThePlayer.Transform:GetWorldPosition()
    for k, v in pairs(AllPlayers) do v.Transform:SetPosition(x, y, z) end]])
    TheFrontEnd:GetActiveScreen():OnClose()
  end)

  local createPage -- Forward declaration

  local function clearPage()
    self.bosses:KillAllChildren()
  end

  local function createBossCard(index, x, y, scale)
    local boss_card = {}
    boss_card.fill = self.bosses:AddChild(Image("images/fepanel_fills.xml", "panel_fill_tall.tex"))
    boss_card.fill:SetPosition(x, y + 115)
    boss_card.fill:SetScale(.25 * scale, .2 * scale)

    if index == 1 or index == 2 or index == 7 or index == 14 then
      boss_card.title = self.bosses:AddChild(Text(NEWFONT_OUTLINE, 32, bosses[index].name:gsub(" ", "\n") or " "))
    else
      boss_card.title = self.bosses:AddChild(Text(NEWFONT_OUTLINE, 39, bosses[index].name or " "))
    end
    boss_card.title:SetPosition(x, y + 143)
    boss_card.title:SetScale(scale)

    boss_card.button = self.bosses:AddChild(ImageButton("images/frontend.xml", "button_long.tex", "button_long_highlight.tex", "button_long_disabled.tex", nil, nil, {0.5,1}, {0,0}))
    boss_card.button:SetPosition(x + 5, y + 67)
    boss_card.button:SetScale(.7 * scale)
    boss_card.button:SetText("Go")
    boss_card.button.text:SetPosition(12, 4)
    boss_card.button:SetFont(BUTTONFONT)
    boss_card.button.icon = boss_card.button:AddChild(Image(bosses[index].iconAtlas or "images/global.xml", bosses[index].iconTex or "square.tex"))
    boss_card.button.icon:SetPosition(-30, 10) -- Left of text
    boss_card.button.icon:SetScale(.8 * scale)
    boss_card.button.icon:SetClickable(false)
    boss_card.button:SetOnClick(function()
      -- RPC to server
      local modName = KnownModIndex:GetModActualName("practice-boss-fights")
      SendModRPCToServer(GetModRPC(modName, "MenuBosses"), index)
      TheFrontEnd:GetActiveScreen():OnClose()
    end)
    
    if index % 8 == 1 then
      boss_card.back_button = self.bosses:AddChild(ImageButton("images/ui.xml", "arrow_left_over.tex"))
      boss_card.back_button:SetPosition(60, -215)
      boss_card.back_button:SetScale(.3 * scale)
      boss_card.back_button:SetFont(BUTTONFONT)

      boss_card.back_button:SetOnClick(function()
        if index > 8 then
          clearPage()
          createPage(index - 8)
        end
      end)

      boss_card.next_button = self.bosses:AddChild(ImageButton("images/ui.xml", "arrow_right_over.tex"))
      boss_card.next_button:SetPosition(155, -215)
      boss_card.next_button:SetScale(.3 * scale)
      boss_card.next_button:SetFont(BUTTONFONT)

      boss_card.next_button:SetOnClick(function()
        if index < #bosses then
          clearPage()
          createPage(index + 8)
        end
      end)
    end
  end
  
  createPage = function(i)
    local x, x_reset = 1, 1
    for card_index = i, math.min(i + 7, #bosses) do
      if x_reset < 5 then
        self.bosses.cards[card_index] = createBossCard(card_index, (x - 2) * 220, -5, 1)
        x, x_reset = x + 1, x_reset + 1
      else
        self.bosses.cards[card_index] = createBossCard(card_index, (x - 1 - x_reset) * 220, -195, 1)
        x = x + 1
      end
    end
  end

  createPage(1)
end)

function Menu:OnClose()
    for k,v in pairs(self.tasks) do
        if v then
            v:Cancel()
        end
    end
  local screen = TheFrontEnd:GetActiveScreen()
  if screen and screen.name:find("HUD") == nil then
    TheFrontEnd:PopScreen()
  end
  TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
end

function Menu:OnControl(control, down)
  if Menu._base.OnControl(self, control, down) then
    return true
  end
  -- Close UI on ESC
  if down and (control == CONTROL_PAUSE or control == CONTROL_CANCEL) then
    self:OnClose()
    return true
  end
end

return Menu