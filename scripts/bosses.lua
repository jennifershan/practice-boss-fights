return {
    {name="Antlion", description="",
    iconAtlas="images/inventoryimages2.xml", iconTex="townportaltalisman.tex",
    activate=function(inst)
      inst.components.inventory:GiveItem(SpawnPrefab("deserthat"))
      inst.components.inventory:GiveItem(SpawnPrefab("heatrock"))
      TheWorld:PushEvent("ms_setseason", "summer")
      TheWorld:PushEvent("ms_forceprecipitation", false)
      ExecuteConsoleCommand("c_gonext('antlion_spawner')")
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
      ExecuteConsoleCommand("c_gonext('beequeenhivegrown')")
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
      ExecuteConsoleCommand("c_gonext('dragonfly_spawner')")
    end},

    {name="Eye of Terror", description="",
    iconAtlas="images/inventoryimages1.xml", iconTex="eyemaskhat.tex",
    activate=function(inst)
      inst.components.inventory:GiveItem(SpawnPrefab("terrarium"))
    end},

    {name="Ancient\nFuelweaver", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="fossil_piece.tex",
    activate=function(inst)
      for i = 1, 8 do
        inst.components.inventory:GiveItem(SpawnPrefab("fossil_piece"))
      end
      inst.components.inventory:GiveItem(SpawnPrefab("atrium_key"))
      inst.components.inventory:GiveItem(SpawnPrefab("shadowheart"))
      ExecuteConsoleCommand("c_gonext('atrium_gate')")
    end},

    {name="Ancient\nGuardian", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="minotaurhorn.tex",
    activate=function(inst)
      ExecuteConsoleCommand("c_gonext('minotaur')")
    end},

    {name="Crab King", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      ExecuteConsoleCommand("c_gonext('crabking')")
    end},

    {name="Celestial\nChampion", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      ExecuteConsoleCommand("c_gonext('alterguardian_phase1')")
    end},

    {name="Klaus", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      ExecuteConsoleCommand("c_gonext('klaus_sack')")
      inst.components.inventory:GiveItem(SpawnPrefab("deer_antler"))
    end},

    {name="Moose/Goose", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      
    end},

    {name="Malbatross", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      
    end},

    {name="Nightmare\nWerepig", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      
    end},

    {name="Shadow Pieces", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      
    end},

    {name="Toadstool", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      inst.components.inventory:GiveItem(SpawnPrefab("canary_poisoned"))
      
    end},

    {name="The Twins", description="",
    iconAtlas="images/inventoryimages.xml", iconTex="",
    activate=function(inst)
      inst.components.inventory:GiveItem(SpawnPrefab("terrarium"))
      inst.components.inventory:GiveItem(SpawnPrefab("nightmarefuel"))
    end},
  }