--[[
    Author: Alternator (Massiner of Nathrezim)
    Copyright 2010
	
	Notes:
]]

local UILib = BFUILib;
local Util = BFUtil;
local Const = BFConst;
local EventFull	= BFEventFrames["Full"];

--This overloading of togglecreatebarmode is yuck, it will do the job for now, but will need
--cleaning up when the ui functions get unified a bit better
function UILib.ToggleCreateBarMode(ForceOff)
	if (BFCreateBarOverlay:IsShown() or ForceOff) then
		BFCreateBarOverlay:Hide();
		BFToolbarCreateBar:SetChecked(false);
		BFToolbarCreateBonusBar:SetChecked(false);
		UILib.CreateBarMode = false;
		UILib.CreateBonusBarMode = false;
		SetCursor(nil);
	elseif (not InCombatLockdown()) then
		UILib.CreateBarMode = true;
		BFCreateBarOverlay:Show();
		BFToolbarCreateBar:SetChecked(true);
		SetCursor("REPAIRNPC_CURSOR");
	end
	EventFull.RefreshButtons = true;
	EventFull.RefChecked = true;
end



function UILib.ToggleCreateBonusBarMode(ForceOff)
	if (not BFConfigureLayer:IsShown()) then
		UIErrorsFrame:AddMessage(Util.GetLocaleString("CreateBonusBarError"), 1, 0, 0);
		return;
	end
	if (BFCreateBarOverlay:IsShown() or ForceOff) then
		BFCreateBarOverlay:Hide();
		BFToolbarCreateBar:SetChecked(false);
		BFToolbarCreateBonusBar:SetChecked(false);
		UILib.CreateBarMode = false;
		UILib.CreateBonusBarMode = false;
		SetCursor(nil);
	elseif (not InCombatLockdown()) then
		UILib.CreateBonusBarMode = true;
		BFCreateBarOverlay:Show();
		BFToolbarCreateBonusBar:SetChecked(true);
		SetCursor("REPAIRNPC_CURSOR");
	end
	EventFull.RefreshButtons = true;
	EventFull.RefChecked = true;
end



function UILib.ToggleDestroyBarMode(ForceOff)
	if (BFDestroyBarOverlay:IsShown() or ForceOff) then
		BFDestroyBarOverlay:Hide();
		BFToolbarDestroyBar:SetChecked(false);
		SetCursor(nil);
		UILib.SetMask(nil);
	elseif (not InCombatLockdown()) then
		BFDestroyBarOverlay:Show();
		BFToolbarDestroyBar:SetChecked(true);
		SetCursor("CAST_ERROR_CURSOR");
	end
	EventFull.RefreshButtons = true;
	EventFull.RefChecked = true;
	Util.VDriverOverride();
	Util.RefreshGridStatus();
	Util.RefreshBarStrata();
	Util.RefreshBarGUIStatus();
end



function UILib.ToggleAdvancedTools()
	if (BFAdvancedToolsLayer:IsShown()) then
		BFAdvancedToolsLayer:Hide();
		BFToolbarAdvanced:SetChecked(false);
		ButtonForgeSave.AdvancedMode = false;
		BFToolbar:SetSize(225, 97);
		BFToolbarCreateBonusBar:Hide();
		BFToolbarRightClickSelfCast:Hide();
	else
		BFAdvancedToolsLayer:Show();
		BFToolbarAdvanced:SetChecked(true);
		ButtonForgeSave.AdvancedMode = true;
		BFToolbar:SetSize(225, 129);
		BFToolbarCreateBonusBar:Show();
		BFToolbarRightClickSelfCast:Show();
	end
	EventFull.RefreshButtons = true;
	EventFull.RefChecked = true;
end

local function GetMouseFocus() -- added for Cata 4.4.1 09/05/2024, copied from retail BF
	local t = GetMouseFoci()
	return t[1]
end

function UILib.ToggleRightClickSelfCast(Value)
	if (Value ~= nil) then
		Util.RightClickSelfCast(Value);	
	elseif (ButtonForgeSave["RightClickSelfCast"]) then
		Util.RightClickSelfCast(false);
	else
		Util.RightClickSelfCast(true);
	end
	
	if (ButtonForgeSave["RightClickSelfCast"]) then
		BFToolbarRightClickSelfCast.Tooltip = Util.GetLocaleString("RightClickSelfCastTooltip")..Util.GetLocaleString("Enabled");
		BFToolbarRightClickSelfCast:SetChecked(true);
	else
		BFToolbarRightClickSelfCast.Tooltip = Util.GetLocaleString("RightClickSelfCastTooltip")..Util.GetLocaleString("Disabled");
		BFToolbarRightClickSelfCast:SetChecked(false);
	end
	
	if (BFToolbarRightClickSelfCast:IsMouseMotionFocus()) then  -- 暫時修正
		GameTooltip:SetText(BFToolbarRightClickSelfCast.Tooltip, nil, nil, nil, nil, 1);
	end
	
	EventFull.RefreshButtons = true;
	EventFull.RefChecked = true;
end


