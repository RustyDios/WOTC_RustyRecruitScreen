//---------------------------------------------------------------------------------------
//  FILE:	 UIRecruitmentListItem_LW.uc
//
//	File created 	04/12/20    06:00
//	LAST UPDATED    06/12/20    11:00
//
//  by RustyDios and Kdm2k6
//  PURPOSE: LW List + Stats + Pool Names
//--------------------------------------------------------------------------------------- 

class UIRecruitmentListItem_Rusty extends UIRecruitmentListItem config(RustyRecruits);

var config int RECRUIT_FONT_SIZE_CTRL, RECRUIT_Y_OFFSET_CTRL;
var config int RECRUIT_FONT_SIZE_MK, RECRUIT_Y_OFFSET_MK;
var config bool bIsPsiVisible, bDisplayPoolClass;

var config bool bShowAim, bShowHP, bShowMob, bShowDef, bShowDodge, bShowHack, bShowWill, bShowPsi;

var XComGameState_Unit MyRecruit;

simulated function InitRecruitItem(XComGameState_Unit Recruit)
{
	super.InitRecruitItem(Recruit);
	
	MyRecruit = Recruit;

	UpdateNameDisplay(Recruit);

	UpdateExistingUI();
	UpdateFlagSize();

	AddDivider();
	AddIcons(Recruit);

	// LW : Hack : Undo the height override set by UIListItemString; don't use SetHeight, as UIListItemString can't handle it.
	Height = 64;
	MC.ChildSetNum("theButton", "_height", 64);
	List.OnItemSizeChanged(self);
}

// KDM : This is called when the confirm button's size is realized; I need to override it to set the x location manually.
simulated function RefreshConfirmButtonLocation()
{
	if (`ISCONTROLLERACTIVE)
	{
		ConfirmButton.SetX(352);
	}
	else
	{
		ConfirmButton.SetX(350);
	}

	RefreshConfirmButtonVisibility();
}

// KDM's : This updates the confirm button, moves the name up and adds an extra new divider line
function UpdateExistingUI()
{
	bAnimateOnInit = false;

	// LW : Move confirm button up.
	if (`ISCONTROLLERACTIVE)
	{
		ConfirmButton.SetY(-3);
	}
	else
	{
		ConfirmButton.SetY(-1);
	}

	// LW : Move soldier name up
	MC.ChildSetNum("soldierName", "_y", 5);
}

function AddDivider()
{
	local UIPanel DividerLine;

	if (DividerLine == none)
	{
		// LW : Extend divider line
		DividerLine = Spawn(class'UIPanel', self);
		DividerLine.bIsNavigable = false;
		DividerLine.InitPanel('DividerLine', class'UIUtilities_Controls'.const.MC_GenericPixel);
		DividerLine.SetColor(class'UIUtilities_Colors'.const.FADED_HTML_COLOR);
		DividerLine.SetSize(2, 56.33);
		DividerLine.SetPosition(90.6, 3.33);
		DividerLine.SetAlpha(66.40625);
	}
}

// KDM's : Adds the Stat Icons, Names them, and sets Text
function AddIcons(XComGameState_Unit Recruit)
{
	local bool PsiStatIsVisible;
	local float XLoc, YLoc, XDelta;

    if (default.bIsPsiVisible || `XCOMHQ.IsTechResearched('Psionics') )
    {
	    PsiStatIsVisible = true; //`XCOMHQ.IsTechResearched('AutopsySectoid'); 
    }

	// KDM : Stat icons, and their associated stat values, have to be manually placed.
	XLoc = 97;
	YLoc = 34.5f;
	XDelta = 65.0f;

	if (PsiStatIsVisible)
	{
		XDelta -= 10.0f;
	}

	InitIconValuePair(Recruit, eStat_Offense,   "Aim",      "UILibrary_RRSImages.StatIcons.Image_Aim",      XLoc, YLoc, default.bShowAim);    	XLoc += XDelta;
	InitIconValuePair(Recruit, eStat_HP,        "Health",   "UILibrary_RRSImages.StatIcons.Image_Health",   XLoc, YLoc, default.bShowHP);    	XLoc += XDelta;
	InitIconValuePair(Recruit, eStat_Mobility,  "Mobility", "UILibrary_RRSImages.StatIcons.Image_Mobility", XLoc, YLoc, default.bShowMob);		XLoc += XDelta;
	InitIconValuePair(Recruit, eStat_Dodge,     "Dodge",    "UILibrary_RRSImages.StatIcons.Image_Dodge",    XLoc, YLoc, default.bShowDodge);    XLoc += XDelta;
	InitIconValuePair(Recruit, eStat_Defense,   "Defense",  "UILibrary_RRSImages.StatIcons.Image_Defense",  XLoc, YLoc, default.bShowDef);		XLoc += XDelta;
	InitIconValuePair(Recruit, eStat_Hacking,   "Hacking",  "UILibrary_RRSImages.StatIcons.Image_Hacking",  XLoc, YLoc, default.bShowHack);		XLoc += XDelta;
    InitIconValuePair(Recruit, eStat_Will,      "Will",     "UILibrary_RRSImages.StatIcons.Image_Will",     XLoc, YLoc, default.bShowWill);    	XLoc += XDelta;

	if (PsiStatIsVisible)
	{
		InitIconValuePair(Recruit, eStat_PsiOffense, "Psi", "gfxXComIcons.promote_psi", XLoc, YLoc, default.bShowPsi);
	}
}

function InitIconValuePair(XComGameState_Unit Recruit, ECharStatType StatType, string MCRoot, string ImagePath, float XLoc, float YLoc, bool bShowStat)
{
	local float IconScale, XOffset, YOffset;
	local UIImage StatIcon;
	local UIText StatValue;

	IconScale = 0.65f;
	XOffset = 26.0f;

	if (GetLanguage() == "JPN")
	{
		YOffset = -3.0;
	}

	if (`ISCONTROLLERACTIVE)
	{
		YOffset += default.RECRUIT_Y_OFFSET_CTRL;
	}
	else
	{
		YOffset += default.RECRUIT_Y_OFFSET_MK;
	}

	if (StatIcon == none)
	{
		StatIcon = Spawn(class'UIImage', self);
		StatIcon.bAnimateOnInit = false;
		StatIcon.InitImage(, ImagePath);
		StatIcon.SetScale(IconScale);
		StatIcon.SetPosition(XLoc, YLoc);
	}

	if (StatValue == none)
	{
		StatValue = Spawn(class'UIText', self);
		StatValue.bAnimateOnInit = false;
		// KDM : Give each UIText a unique name, so that it can be accessed by that name when list item focus changes.
		StatValue.InitText(name(MCRoot $ "_Rusty"));
		StatValue.SetPosition(XLoc + XOffset, YLoc + YOffset);
	}

	if (bShowStat)
	{
		StatValue.Text = string(int(Recruit.GetCurrentStat(StatType)));
	}
	else
	{
		StatValue.Text = "##";
	}
	StatValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(StatValue.Text, eUIState_Normal, GetFontSize()));
}

///////////////////////////////////////////////////////////////////
//	REFRESH AND UPDATES
///////////////////////////////////////////////////////////////////

simulated function OnReceiveFocus()
{
	super.OnReceiveFocus();
	RefreshText();
}

simulated function OnLoseFocus()
{
	super.OnLoseFocus();
	RefreshText();
}

function RefreshText()
{
	UpdateNameDisplay();
	UpdateFlagSize();
	UpdateDivider();

	UpdateText("Aim",		eStat_Offense);
	UpdateText("Health",	eStat_HP);
	UpdateText("Mobility",	eStat_Mobility);
	UpdateText("Dodge",		eStat_Dodge);
	UpdateText("Defense",	eStat_Defense);
	UpdateText("Hacking",	eStat_Hacking);
	UpdateText("Will",		eStat_Will);
	UpdateText("Psi",		eStat_PsiOffense);
}

function UpdateFlagSize()
{
	// LW : Update flag size and position
	MC.BeginChildFunctionOp("flag", "setImageSize");  
	MC.QueueNumber(81);
	MC.QueueNumber(42);
	MC.EndOp();
	MC.ChildSetNum("flag", "_x", 7);
	MC.ChildSetNum("flag", "_y", 10.5);
}

function UpdateDivider()
{
	local UIPanel DividerLine;

	DividerLine = GetChildByName('DividerLine', false);
	DividerLine.SetColor(class'UIUtilities_Colors'.const.FADED_HTML_COLOR);
	DividerLine.SetSize(2, 56.33);
	DividerLine.SetPosition(90.6, 3.33);
	DividerLine.SetAlpha(66.40625);

}

//function to find the units class set in the pool
function string GetPoolClassName(XComGameState_Unit Recruit) 
{
	local XComGameState_Unit poolUnit;
	local string ClassName;

	poolUnit = `CHARACTERPOOLMGR.GetCharacter(Recruit.GetFullName());

	if ( poolUnit != none ) 
	{
		ClassName = poolUnit.GetSoldierClassTemplate().DisplayName; //"class name", not the template name
	}
	else
	{
		ClassName = class'X2ExperienceConfig'.static.GetRankName(0,name("")); //"rookie", fallback option
	}

	return ": <font color='#546f6f'>(" $ClassName $") </font>"; // faded cyan colour, see UIUtilitiesColours
}

function int GetFontSize()
{
	return (`ISCONTROLLERACTIVE) ? default.RECRUIT_FONT_SIZE_CTRL : default.RECRUIT_FONT_SIZE_MK;
}

function UpdateNameDisplay(optional XComGameState_Unit Recruit)
{
	local bool Focused;
	local string RecruitName;

	Focused = bIsFocused;

	if (Recruit == none)
	{
		Recruit = MyRecruit;
	}

	RecruitName = Recruit.GetFullName();

	// Inclusion of Krj12's Expanded Recruit Screen, if focused text is black/grey, if not cyan/grey
	// KDM : Change the text colour based on whether this list item is focused or not.
	// Rusty : and then change the text colour based on if the item is disabled or not
	if (default.bDisplayPoolClass)
	{
		RecruitName = RecruitName @GetPoolClassName(Recruit);
	}
		
	if (Focused)
	{
		AS_PopulateData(Recruit.GetCountryTemplate().FlagImage, class'UIUtilities_Text'.static.GetColoredText(RecruitName, -1, GetFontSize())); //-1 defaults to black
	}
	else
	{
		AS_PopulateData(Recruit.GetCountryTemplate().FlagImage, class'UIUtilities_Text'.static.GetColoredText(RecruitName, (bDisabled ? eUIState_Disabled : eUIState_Normal), GetFontSize()));
	}
}

function UpdateText(string MCRoot, ECharStatType StatType, optional XComGameState_Unit Recruit)
{
	local bool Focused;
	local string OriginalText, CheckValue;
	local UIText StatValue;

	Focused = bIsFocused;

	if (Recruit == none)
	{
		Recruit = MyRecruit;
	}

	// KDM : Get the UIText according to its name.
	StatValue = UIText(GetChildByName(name(MCRoot $ "_Rusty"), false));

	if (StatValue != none && Recruit != none)
	{
		OriginalText = StatValue.Text;
		CheckValue = string(int(Recruit.GetCurrentStat(StatType)));

		//ensure the stats are upto date
		if (OriginalText != CheckValue && OriginalText != "##")
		{
			OriginalText = CheckValue;
		}

		// KDM : Change the text colour based on whether this list item is focused or not.
		// Rusty : and then change the text colour based on if the item is disabled or not
		if (Focused)
		{
			StatValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(OriginalText, -1, GetFontSize())); //set to black
		}
		else
		{
			StatValue.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(OriginalText, (bDisabled ? eUIState_Disabled : eUIState_Normal), GetFontSize()));
		}
	}
}
