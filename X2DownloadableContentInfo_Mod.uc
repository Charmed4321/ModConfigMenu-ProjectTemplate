//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_$ModSafeName$.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_$ModSafeName$ extends X2DownloadableContentInfo;

`include($ModSafeName$/Src/ModConfigMenuAPI/MCM_API_Includes.uci);
`include($ModSafeName$/Src/ModConfigMenuAPI/MCM_API_CfgHelpers.uci);

`MCM_CH_VersionChecker(class'$ModSafeName$_MCMConfig'.default.CONFIG_VERSION,class'$ModSafeName$_MCMListener'.default.CONFIG_VERSION)


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

static event OnPostTemplatesCreated()
{}

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{}