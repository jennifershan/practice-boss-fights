return {
  {name="Ancient Fuelweaver", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="fossil_piece.tex",
  activate=function(inst)
    c_gonext("atrium_gate")
    if GetModConfigData("start_fw", KnownModIndex:GetModActualName("practice-boss-fights")) then
      for i = 1, 8 do
        inst.components.inventory:GiveItem(SpawnPrefab("fossil_piece"))
      end
      inst.components.inventory:GiveItem(SpawnPrefab("atrium_key"))
      inst.components.inventory:GiveItem(SpawnPrefab("shadowheart"))
    end
  end},

  {name="Ancient Guardian", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="minotaurhorn.tex",
  activate=function(inst)
    c_gonext("minotaur_ruinsrespawner_inst")
  end},

  {name="Antlion", description="",
  iconAtlas="images/inventoryimages2.xml", iconTex="townportaltalisman.tex",
  activate=function(inst)
    TheWorld:PushEvent("ms_setseason", "summer")
    TheWorld:PushEvent("ms_forceprecipitation", false)
    c_gonext("antlion_spawner")
  end},

  {name="Bearger", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="bearger_fur.tex",
  activate=function(inst)
    TheWorld:PushEvent("ms_setseason", "autumn")
    local pos = inst:GetPosition()
    local r = 10
    local angle = math.random(360) * math.pi / 180
    local ptx, ptz = pos.x + r * math.cos(angle), pos.z + r * math.sin(angle)
    SpawnPrefab("bearger").Transform:SetPosition(ptx, pos.y, ptz)
  end},

  {name="Bee Queen", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="hivehat.tex",
  activate=function(inst)
    c_gonext("beequeenhivegrown")
  end},

  {name="Crab King", description="",
  iconAtlas="images/inventoryimages2.xml", iconTex="trident.tex",
  activate=function(inst)
    local ck = TheSim:FindFirstEntityWithTag("crabking_spawner")
    if ck then
      local cx, cy, cz = ck.Transform:GetWorldPosition()
      local r = 5
      local angle = math.random(360) * math.pi / 180
      local ptx, ptz = cx + r * math.cos(angle), cz + r * math.sin(angle)
      local boat = SpawnPrefab("boat")
      boat.Transform:SetPosition(ptx, cy, ptz)
      inst.Physics:Teleport(ptx, cy, ptz)
      inst:SnapCamera() 
    end
    if GetModConfigData("start_ck", KnownModIndex:GetModActualName("practice-boss-fights")) then
      inst.components.inventory:GiveItem(SpawnPrefab("hermit_pearl"))
    end
  end},

  {name="Celestial Champion", description="",
  iconAtlas="images/inventoryimages1.xml", iconTex="alterguardianhatshard.tex",
  activate=function(inst)
    TheWorld:PushEvent("ms_startthemoonstorms")
    c_gonext("moon_fissure")
    local pos = inst:GetPosition()
    local r = 10
    local angle = math.random(360) * math.pi / 180
    local ptx, ptz = pos.x + r * math.cos(angle), pos.z + r * math.sin(angle)
    SpawnPrefab("alterguardian_phase1").Transform:SetPosition(ptx, pos.y, ptz)
  end},

  {name="Deerclops", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="deerclops_eyeball.tex",
  activate=function(inst)
    TheWorld:PushEvent("ms_setseason", "winter")
    local pos = inst:GetPosition()
    local r = 10
    local angle = math.random(360) * math.pi / 180
    local ptx, ptz = pos.x + r * math.cos(angle), pos.z + r * math.sin(angle)
    SpawnPrefab("deerclops").Transform:SetPosition(ptx, pos.y, ptz)
  end},

  {name="Dragonfly", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="dragon_scales.tex",
  activate=function(inst)
    c_gonext("dragonfly_spawner")
  end},

  {name="Eye of Terror", description="",
  iconAtlas="images/inventoryimages1.xml", iconTex="eyemaskhat.tex",
  activate=function(inst)
    if GetModConfigData("start_eot", KnownModIndex:GetModActualName("practice-boss-fights")) then
      inst.components.inventory:GiveItem(SpawnPrefab("terrarium"))
    end
    TheWorld:PushEvent("ms_setphase", "night")
  end},

  {name="Klaus", description="",
  iconAtlas="images/inventoryimages1.xml", iconTex="deer_antler1.tex",
  activate=function(inst)
    if GetModConfigData("start_kl", KnownModIndex:GetModActualName("practice-boss-fights")) then
      inst.components.inventory:GiveItem(SpawnPrefab("deer_antler"))
    end
    TheWorld:PushEvent("ms_setseason", "winter")
    local pos = inst:GetPosition()
    local r = 10
    local angle = math.random(360) * math.pi / 180
    local ptx, ptz = pos.x + r * math.cos(angle), pos.z + r * math.sin(angle)
    SpawnPrefab("klaus_sack").Transform:SetPosition(ptx, pos.y, ptz)
  end},

  {name="Moose/Goose", description="",
  iconAtlas="images/inventoryimages1.xml", iconTex="goose_feather.tex",
  activate=function(inst)
    if not TheWorld:HasTag("cave") then
      TheWorld:PushEvent("ms_setseason", "spring")
      c_gonext("moose_nesting_ground")
      TheWorld.components.moosespawner:DoHardSpawn(inst)
    end
  end},

  {name="Malbatross", description="",
  iconAtlas="images/inventoryimages2.xml", iconTex="malbatross_feather.tex",
  activate=function(inst)
    if not TheWorld:HasTag("cave") then
      c_gonext("oceanfish_shoalspawner")
      local boat = SpawnPrefab("boat")
      boat.Transform:SetPosition(inst:GetPosition():Get())
      c_summonmalbatross()
    end
  end},

  {name="Nightmare Werepig", description="",
  iconAtlas="images/inventoryimages1.xml", iconTex="horrorfuel.tex",
  activate=function(inst)
    c_gonext("daywalker")
  end},

  {name="Shadow Pieces", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="shadowheart.tex",
  activate=function(inst)
    TheWorld:PushEvent("ms_setphase", "night")
    TheWorld:PushEvent("ms_setmoonphase", {moonphase = "new", iswaxing = true})
  end},

  {name="Toadstool", description="",
  iconAtlas="images/inventoryimages.xml", iconTex="shroom_skin.tex",
  activate=function(inst)
    c_gonext("toadstool_cap")
    if GetModConfigData("start_mt", KnownModIndex:GetModActualName("practice-boss-fights")) then
      inst.components.inventory:GiveItem(SpawnPrefab("canary_poisoned"))
    end
  end},

  {name="The Twins", description="",
  iconAtlas="images/inventoryimages2.xml", iconTex="shieldofterror.tex",
  activate=function(inst)
    TheWorld:PushEvent("ms_setphase", "night")
    if GetModConfigData("start_tt", KnownModIndex:GetModActualName("practice-boss-fights")) then
      inst.components.inventory:GiveItem(SpawnPrefab("terrarium"))
      inst.components.inventory:GiveItem(SpawnPrefab("nightmarefuel"))
    end
  end},
}