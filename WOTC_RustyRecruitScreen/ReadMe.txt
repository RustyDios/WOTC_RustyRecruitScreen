You created an XCOM 2 Mod Project!

https://steamcommunity.com/sharedfiles/filedetails/?id=718878303  Krj12's Enhanced Recruitment Lists 
https://steamcommunity.com/sharedfiles/filedetails/?id=1131878283 SaintKnaves Recruits Conserve Character Pool
https://steamcommunity.com/sharedfiles/filedetails/?id=2116413401 Kdm2k6's LWotC Recruits Stat Display
Merged all these into 'one thing'

https://steamcommunity.com/sharedfiles/filedetails/?id=1128263618 -BGs- Detailed Soldier Lists (Icons)
https://steamcommunity.com/sharedfiles/filedetails/?id=2276175904 Standardised Resource Bar, for the supplies total


known issues...
https://steamcommunity.com/sharedfiles/filedetails/?id=1124885122 SWR NCE >> randomises its stats based on a UISL for the UIAvengerHUD, 
    so you need to back out of the recruits screen and come back in to refresh the Display after purchase
https://steamcommunity.com/sharedfiles/filedetails/?id=1124521276 Charmed NCE >> didn't test but it might be okay, not sure how it does it's thing by config only?
https://steamcommunity.com/sharedfiles/filedetails/?id=1144463583 Shires PBNCE should work fine

MUGSHOTS may take some time to load, but they will load


Won't work in LWotC due to MCO clashes, they use thier own screen (Kdm2k6's)
Will work in Covert Infiltration, RPGO and obviously WOTC.

==============================================================================
STEAM DESC		https://steamcommunity.com/sharedfiles/filedetails/?id=2310899968
==============================================================================
[h1] What is this ?[/h1]
This mod is a combination of [url=https://steamcommunity.com/sharedfiles/filedetails/?id=718878303] Krj12's Enhanced Recruitment Lists [/url], [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1131878283] SaintKnaves Recruits Conserve Character Pool [/url] and [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2116413401] Kdm2k6's LWotC Recruits Stat Display [/url].

The code is about 80% [b]Kdm2k6's[/b] and [i]made with his permission[/i]. However I was unable to contact [b]SaintKnave[/b] or [b]Krj12[/b].
The reason I've made this is that the three parent mod all use a ModClassOverride, MCO, on the same class [b]UIRecruitSoldiers[/b] so cannot work together but they all had interesting features and I couldn't pick which one to use. So I merged them.

[h1] The Result [/h1]
So in this mod we get the base of the 'LWotC Stat Display' recruit screen, with the extra bit of information of 'Enhanced List' and the functionality of 'Conserve Units'.

[list]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=718878303] Krj12's Enhanced Recruitment Lists [/url]: 
Displays the soldier class as specified in the character pool, useful for mods like [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1125727531] Use My Class [/url]
This can be turned off in the config if you wish.
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1131878283] SaintKnaves Recruits Conserve Character Pool [/url]:
Uses a config ini change to stop adding soldiers to the Recruit Soldiers list every month and instead adds a new recruit whenever you purchase one. This helps to preserve your carefully constructed character pool soldiers to actually be findable and usable during your campaign.
No more will your favorite end up languishing in the recruitment pool, never to see the shiny side of a Sectoid.
This can be turned off in the config if you wish.
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2116413401] Kdm2k6's LWotC Recruits Stat Display [/url]:
The bulk of the mod. An amazing focus colour changing stat displaying, mugshot taking beast of a mod. Extremely useful with mods like [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1144463583] Shiremcts Point Based Not Created Equal [/url].
Has config options for which stats to display and which ones to obsfucate.
[/list]

[h1] Configs [/h1]
So as well as configs for the features of the above, I also included all the 'recruitment' configs I could find from [b]XComGameData.ini[/b]. This includes the Starting Barracks Recruits (set at 7, to let your pool soldiers be rewards), Number of Recruits each supply drop (set at 0, recruits appear when you hire one) and Cost of Recruits (set at 20, 25, 25, 42 per difficulty).
There are also options for how long recruits take to show up (left at the default of 0hrs) and if the recruit pool should use the pool, randoms or mixed soldiers. I set this to 'pool' so the recruits will always prioritise Pool Soldiers if they haven't been assigned already.

[h1] Other Notes [/h1]
This new Recruit Screen technically needs my [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2276175904] Standardised Resource Bar [/url] (or a similar mod that supports the new screen) to display the number of supplies you have in the resource bar. I already had all the setup in that mod and didn't feel like merging more stuff into this.
You can just as easily get by without this so not a hard-requirement.

I can't actually recall where the status icons come from, it was either [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1128263618] Detailed Soldier Lists [/url] or the original [url=https://steamcommunity.com/sharedfiles/filedetails/?id=674832831] LW Toolbox [/url], they've been sat on my PC for so long I lost my source notes. Sorry.

Should be fine for a mid-campaign strategy save install. The display should update instantly, but your mileage will vary with some features depending on the state of your game prior.

[h1] Known Issues [/h1]
[olist]
[*]Nothing is 'perfect' ... obviously this mod suffers the same problem of the original 3 and uses a MCO of [b]UIRecruitSoldiers[/b], it will therefore not work with any mod that does the same, yes including LWotC, lol!.
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1124885122] SWR NCE [/url] randomises its stats based on a UISL for the UIAvengerHUD, so you need to back out of the recruits screen and come back in to refresh the Stats Display after hiring
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1124521276] Charmed's NCE [/url] I didn't test but it might be okay, not sure how it does it's thing by config only?
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1144463583] Shiremcts PBNCE [/url] should work fine (and is what I tested with)
[*]Mugshots/Headshots may take a while to load. The system catches up eventually, but in one case I was waiting a good 2 minutes, this may be a reflection of my potato PC :)
[/olist]

[h1] Credits [/h1]
Obvious credits to the three original mods, links above, without which this really would never have been possible.
My thanks also to the XCom2 Modders Discords for amazing support over the last year.

~ Enjoy [b]!![/b] and please [url=https://www.buymeacoffee.com/RustyDios] buy me a Cuppa Tea[/url]

==============================================================================
==============================================================================
UILibrary_RRSImages.StatIcons.Image_Aim
UILibrary_RRSImages.StatIcons.Image_Health
UILibrary_RRSImages.StatIcons.Image_Mobility
UILibrary_RRSImages.StatIcons.Image_Dodge
UILibrary_RRSImages.StatIcons.Image_Defense
UILibrary_RRSImages.StatIcons.Image_Hacking
UILibrary_RRSImages.StatIcons.Image_Will
