//---------------------------------------------------------------------------------------
//  FILE:	 UIRecruitSoldiers_LW.uc
//
//	File created 	04/12/20    06:00
//	LAST UPDATED    06/12/20    11:00
//
//  by RustyDios and Kdm2k6 and SaintKnave
//  PURPOSE: LW Stats Display recruit screen with conserve pool
//--------------------------------------------------------------------------------------- 

class UIRecruitSoldiers_Rusty extends UIRecruitSoldiers config(RustyRecruits);

var config bool bBuyingRefills, bRandomRookieRoll;

// But for one function call, this function is identical to the default
simulated function OnRecruitSelected( UIList kList, int itemIndex )
{
	local XComGameState_Unit Recruit;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_HeadquartersResistance ResistanceHQ;

	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
	ResistanceHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();

	if(XComHQ.GetSupplies() >= ResistanceHQ.GetRecruitSupplyCost())
	{
		Recruit = m_arrRecruits[itemIndex];
		
		`XSTRATEGYSOUNDMGR.PlaySoundEvent("StrategyUI_Recruit_Soldier");
		ResistanceHQ.GiveRecruit(Recruit.GetReference());

        if (default.bBuyingRefills)
        {
		    AddNewRecruitToList(); // Call the new function, pulling a new recruit from the pool
        }

		UpdateData();

		`HQPRES.m_kAvengerHUD.UpdateResources();
	}
	else
	{
		if( XComHQ.GetSupplies() < ResistanceHQ.GetRecruitSupplyCost()) 
        {
			NotEnoughSuppliesDialogue();
        }
	}
}

// creates a new recruit from the pool when one is purchased ... conserve the pool in conjunction with some config settings
simulated function AddNewRecruitToList()
{
	local XComGameState NewGameState;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersResistance ResistanceHQ;
	local XComGameState_Unit SoldierState;
	local XComOnlineProfileSettings ProfileSettings;

	History = `XCOMHISTORY;
    ProfileSettings = `XPROFILESETTINGS;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add New Recruit To List");
	ResistanceHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	ResistanceHQ = XComGameState_HeadquartersResistance(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersResistance', ResistanceHQ.ObjectID));

	SoldierState = `CHARACTERPOOLMGR.CreateCharacter(NewGameState, ProfileSettings.Data.m_eCharPoolUsage);

	if (default.bRandomRookieRoll)
	{
		SoldierState.RandomizeStats();
	}

	if(!SoldierState.HasBackground())
    {
		SoldierState.GenerateBackground();
    }
    
	SoldierState.ApplyInventoryLoadout(NewGameState);

	ResistanceHQ.Recruits.AddItem(SoldierState.GetReference());	//RefillRecruits code would rebuild the Recruits list here. Why? Needed?
	UIRecruitmentListItem_Rusty(List.CreateItem(class'UIRecruitmentListItem_Rusty')).InitRecruitItem(SoldierState);

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
}

//list update by kdm2k6 to call list items with stats display, slightly adapted
simulated function UpdateData()
{
	local int i;
	local XComGameState_Unit Recruit;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersResistance ResistanceHQ;
	
	AS_SetTitle(m_strListTitle);

	List.ClearItems();
	m_arrRecruits.Length = 0;

	History = `XCOMHISTORY;
	ResistanceHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));

	if (ResistanceHQ != none)
	{
		for (i = 0; i < ResistanceHQ.Recruits.Length; i++)
		{
			Recruit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ResistanceHQ.Recruits[i].ObjectID));
			m_arrRecruits.AddItem(Recruit);
			// KDM : Create and add our custom list items to the list.
			UIRecruitmentListItem_Rusty(List.CreateItem(class'UIRecruitmentListItem_Rusty')).InitRecruitItem(Recruit);
			UpdateAndCheckPicture(Recruit, i);
		}
	}

	if (m_arrRecruits.Length > 0)
	{
		// KDM : If we don't call RealizeList(), the bottom of the list gets cut off after recruiting a soldier.
		List.RealizeList();
		List.SetSelectedIndex(0, true);
	}
	else
	{
		List.SetSelectedIndex(-1, true);
		AS_SetEmpty(m_strNoRecruits);
	}
}

//ensure we have the right staff picture by taking it again
//this fixed some weird issues with people getting stuck with the wrong photo
function UpdateAndCheckPicture(XComGameState_Unit Recruit, int itemIndex )
{
	local Texture2D StaffPicture;
	local XComGameState_CampaignSettings SettingsState;
	local StateObjectReference DeferredUnitRef;

	AS_SetPicture(); // hide picture until character portrait is loaded

	SettingsState = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));
	StaffPicture = `XENGINE.m_kPhotoManager.GetHeadshotTexture(SettingsState.GameIndex, Recruit.GetReference().ObjectID, 512, 512);

	if (StaffPicture != none)
	{
		DeferredSoldierPictureListIndex = itemIndex;
		ClearTimer(nameof(DeferredUpdateSoldierPicture));
		SetTimer(0.1f, false, nameof(DeferredUpdateSoldierPicture));
	}

	if (Recruit.GetReference() == DeferredUnitRef)
	{
		AS_SetPicture(class'UIUtilities_Image'.static.ValidateImagePath(PathName(StaffPicture)));
	}
}