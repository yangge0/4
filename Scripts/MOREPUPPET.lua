local MOREPUPPET = GameMain:GetMod("MOREPUPPET");
MOREPUPPET.time = 0;
MOREPUPPET.flag = 0;
MOREPUPPET.puppetcount = 0;


function MOREPUPPET:OnSetHotKey()
	local tbHotKeys = {

		{ ID = "MOREPUPPET", Name = "开局傀儡", Type = "Mod", InitialKey1 = "LeftShift + W", InitialKey2 = "RightShift + W" },

	}
	return tbHotKeys
end

function MOREPUPPET:OnHotKey(ID,State)

	if ID == "MOREPUPPET" and State == "down" then
		print("开始添加傀儡")
		MOREPUPPET:AddMorePuppet()
    end

end

function MOREPUPPET:AddMorePuppet()
	if CS.XiaWorld.FightMapMgr.Instance.MapSchool == 0 then

		MOREPUPPET:MorePuppetCount()
		print("开始添加傀儡1")
		if  MOREPUPPET.puppetcount < 3   then
			for i = 1, 3-MOREPUPPET.puppetcount do
				print("开始添加傀儡2")
				local npc3 = CS.XiaWorld.ThingMgr.Instance:AddPuppet(12, CS.XiaWorld.World.Instance.map:RandomBronGrid())
				npc3.PropertyMgr:ModifierProperty("MoveSpeed", 30, 0, 0, 0)
				npc3:SetName(CS.TFMgr.LuaGet("劳工傀儡"))
				npc3.Author = ""
			end

		end
	end
end


function MOREPUPPET:OnStep(dt)

end

function MOREPUPPET:MorePuppetCount()
	local NpcList = Map.Things:GetNpcsLua(
		function(n)
			return n.IsPuppet and not n.IsDeath
		end)

		for i, npc in pairs(NpcList) do
			MOREPUPPET.puppetcount  = MOREPUPPET.puppetcount +1
		end

end

function MOREPUPPET:OnSave()
	local tbSave = {
		flag = MOREPUPPET.flag
	}

	return tbSave
end

function MOREPUPPET:OnLoad(tbLoad)
	MOREPUPPET.flag= tbLoad[flag] or 0
end
