local NiaoYoo= GameMain:GetMod("NiaoYoo");--先注册一个新的MOD模块
local tbEvent = GameMain:GetMod("_Event");
NiaoYoo.flag = 0;
NiaoYoo.title = "辅助模式";
function NiaoYoo:OnInit()

end


function NiaoYoo:OnEnter()
	tbEvent:RegisterEvent(g_emEvent.SecretUpdate, NiaoYoo.OnSecretUpdate, "NiaoYoo")
end

function NiaoYoo:OnLeave()
	tbEvent:UnRegisterEvent(g_emEvent.SecretUpdate, "NiaoYoo")
end


function NiaoYoo.OnSecretUpdate(t,obj)
	if PlacesMgr:IsLocked("Place_FeiLingShan") == true then
		if MapStoryMgr:HasSecret(144002) == true then
			PlacesMgr:UnLockPlace("Place_FeiLingShan");
			MapStoryMgr:GetSecretDef(144002).Hide = true
		end
	end
end



function NiaoYoo:OnStep()

-- CS.XiaWorld.PlacesMgr.Instance:UnLockPlace("Place_OldLingShan") --废弃灵山
end



function NiaoYoo:OnSetHotKey()
	local tbHotKeys = {

		{ ID = "QuickBuild", Name = "建造模式", Type = "Mod", InitialKey1 = "LeftControl + B", InitialKey2 = "RightControl + B" },
		{ ID = "QuickWork", Name = "快速工作", Type = "Mod", InitialKey1 = "LeftControl + T", InitialKey2 = "RightControl + T" },

	}
	return tbHotKeys
end

function NiaoYoo:OnHotKey(ID,state)
	if ID == "QuickBuild" and state == "down" then
		if CS.GameMain.Instance.QuickBuild then
			CS.GameMain.Instance.QuickBuild = false;
			world:ShowMsgBox("建造模式已关闭",NiaoYoo.title);
			print("建造模式已关闭");
		else
			CS.GameMain.Instance.QuickBuild = true;
			world:ShowMsgBox("建造模式已开启",NiaoYoo.title);
			print("建造模式已开启");
		end
    end
	if ID == "QuickWork" and state == "down" then
		if CS.GameMain.Instance.QuickWork then
			CS.GameMain.Instance.QuickWork = false;
			world:ShowMsgBox("快速工作已关闭",NiaoYoo.title);
			print("快速工作已关闭");
		else
			CS.GameMain.Instance.QuickWork = true;
			world:ShowMsgBox("快速工作已开启",NiaoYoo.title);
			print("快速工作已开启");
		end
    end
end



function NiaoYoo:OnSave()
	local tbSave = {
		flag = NiaoYoo.flag
	}

	return tbSave
end

function NiaoYoo:OnLoad(tbLoad)
	NiaoYoo.flag= tbLoad[flag] or 0
end
