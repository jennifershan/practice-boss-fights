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
  self.title:SetPosition(0, 250)
  
  self.bosses = self.proot:AddChild(Widget("ROOT"))
  self.bosses:SetPosition(-100, 0)
  self.bosses.cards = {}

  self.ent_cave = self.proot:AddChild(ImageButton("minimap/minimap_data.xml", "cave_open.png"))
  self.ent_cave:SetPosition(-100, -220)
  self.ent_cave:SetOnClick(function()
  end)

  self.ex_cave = self.proot:AddChild(ImageButton("minimap/minimap_data.xml", "cave_open2.png"))
  self.ex_cave:SetPosition(110, -220)
  self.ex_cave:SetOnClick(function()
  end)

  local createPage -- Forward declaration

  local function clearPage()
    self.bosses:KillAllChildren()
  end

  local function createBossCard(index, x, y, scale)
    local boss_card = {}
    boss_card.fill = self.bosses:AddChild(Image("images/fepanel_fills.xml", "panel_fill_tall.tex"))
    boss_card.fill:SetPosition(x, y + 110)
    boss_card.fill:SetScale(.25 * scale, .2 * scale)

    if string.find(bosses[index].name, "\n") then
      boss_card.title = self.bosses:AddChild(Text(NEWFONT_OUTLINE, 32, bosses[index].name or " "))
    else
      boss_card.title = self.bosses:AddChild(Text(NEWFONT_OUTLINE, 39, bosses[index].name or " "))
    end
    boss_card.title:SetPosition(x, y + 140)
    boss_card.title:SetScale(scale)

    boss_card.button = self.bosses:AddChild(ImageButton("images/frontend.xml", "button_long.tex", "button_long_highlight.tex", "button_long_disabled.tex", nil, nil, {0.5,1}, {0,0}))
    boss_card.button:SetPosition(x + 5, y + 60)
    boss_card.button:SetScale(.7 * scale)
    boss_card.button:SetText("Go")
    boss_card.button.text:SetPosition(11, 4)
    boss_card.button:SetFont(BUTTONFONT)
    boss_card.button.icon = boss_card.button:AddChild(Image(bosses[index].iconAtlas or "images/global.xml", bosses[index].iconTex or "square.tex"))
    boss_card.button.icon:SetPosition(-30, 10) -- Left of text
    boss_card.button.icon:SetScale(.8 * scale)
    boss_card.button.icon:SetClickable(false)
    boss_card.button:SetOnClick(function()
      -- RPC to server
      local modName = KnownModIndex:GetModActualName("practice-boss-fights")
      SendModRPCToServer(GetModRPC(modName, "Menu Bosses"), index)
      TheFrontEnd:GetActiveScreen():OnClose()
    end)
    
    if index % 8 == 1 then
      boss_card.back_button = self.bosses:AddChild(ImageButton("images/global_redux.xml", "arrow2_left_down.tex", "arrow2_left_over.tex", nil, nil, nil, {1,1}, {0,0}))
      boss_card.back_button:SetPosition(60, -220)
      boss_card.back_button:SetScale(.5 * scale)
      boss_card.back_button:SetFont(BUTTONFONT)

      boss_card.back_button:SetOnClick(function()
        if index > 8 then
          clearPage()
          createPage(index - 8)
        end
      end)

      boss_card.next_button = self.bosses:AddChild(ImageButton("images/global_redux.xml", "arrow2_right_down.tex", "arrow2_right_over.tex", nil, nil, nil, {1,1}, {0,0}))
      boss_card.next_button:SetPosition(150, -220)
      boss_card.next_button:SetScale(.5 * scale)
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
        self.bosses.cards[card_index] = createBossCard(card_index, (x - 2) * 220, 0, 1)
        x, x_reset = x + 1, x_reset + 1
      else
        self.bosses.cards[card_index] = createBossCard(card_index, (x - 1 - x_reset) * 220, -200, 1)
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