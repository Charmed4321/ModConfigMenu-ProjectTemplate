//Set up the MCM menu here. The config must be a non-existent config in the mod folder, so that it will be created by xcom2.

class $ModSafeName$_MCMListener extends UIScreenListener config($ModSafeName$);

`include($ModSafeName$/Src/ModConfigMenuAPI/MCM_API_Includes.uci);
`include($ModSafeName$/Src/ModConfigMenuAPI/MCM_API_CfgHelpers.uci);

var config float SETTING;
var config bool bSETTING;
var config int CONFIG_VERSION;

event OnInit(UIScreen Screen)
{
	if (MCM_API(Screen) != none)
	{
		`MCM_API_Register(Screen, ClientModCallback);
	}
}

simulated function ClientModCallback(MCM_API_Instance ConfigAPI, int GameMode)
{
    local MCM_API_SettingsPage Page;
    local MCM_API_SettingsGroup Group;
    
    LoadSavedSettings();
    
    Page = ConfigAPI.NewSettingsPage("Mod");
    Page.SetPageTitle("Mod");
    Page.SetSaveHandler(SaveButtonClicked);
    
    Group = Page.AddGroup('Group1', "General Settings");
    
    Group.AddSlider('slider', "Setting", "Tooltip", 0.0, 10.0, 1, SETTING, , SliderSaveHandler);
	Group.AddCheckbox('checkbox', "Setting", "Tooltip", bSETTING, CheckboxSaveHandler);
    
    Page.ShowSettings();
}

`MCM_CH_VersionChecker(class'$ModSafeName$_MCMConfig'.default.CONFIG_VERSION,CONFIG_VERSION)

simulated function LoadSavedSettings()
{
    SETTING = `MCM_CH_GetValue(class'$ModSafeName$_MCMConfig'.default.SETTING,SETTING);
	bSETTING = `MCM_CH_GetValue(class'$ModSafeName$_MCMConfig'.default.bSETTING,bSETTING);
}

//Every setting needs its own save handler here (slidersavehandler2, 3, etc...)
`MCM_API_BasicSliderSaveHandler(SliderSaveHandler, SETTING)
`MCM_API_BasicCheckboxSaveHandler(CheckboxSaveHandler, bSETTING)

simulated function SaveButtonClicked(MCM_API_SettingsPage Page)
{
    self.CONFIG_VERSION = `MCM_CH_GetCompositeVersion();
    self.SaveConfig();
}

/* //these example functions can be added to other classes to get the values out
function float GetValue()
{
	local float value;
	value = `MCM_CH_GetValue(class'$ModSafeName$_MCMConfig'.default.SETTING,class'$ModSafeName$_MCMListener'.default.SETTING);
    return value;
}

function bool GetBool()
{
    return `MCM_CH_GetValue(class'$ModSafeName$_MCMConfig'.default.bSETTING,class'$ModSafeName$_MCMListener'.default.bSETTING);;
}
*/

defaultproperties
{
    ScreenClass = none;
}
