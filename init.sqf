//PRECOMPILE
T_escobarController 		= compileFinal preProcessFileLineNumbers "escobarController.sqf";
T_lieutenantController		= compileFinal preProcessFileLineNumbers "lieutenantController.sqf";
T_setGroupSide				= compileFinal preProcessFileLineNumbers "setGroupSide.sqf";
T_scheduleMeeting			= compileFinal preProcessFileLineNumbers "scheduleMeeting.sqf";
T_establishSmugglingRoute	= compileFinal preProcessFileLineNumbers "establishSmugglingRoute.sqf";
T_ambientVehicles			= compileFinal preProcessFileLineNumbers "ambientVehicles.sqf";
T_parkingMeterVehicles		= compileFinal preProcessFileLineNumbers "parkingMeterVehicles.sqf";
T_fenceVehicles				= compileFinal preProcessFileLineNumbers "fenceVehicles.sqf";
T_houseVehicles				= compileFinal preProcessFileLineNumbers "houseVehicles.sqf";
T_collisionDetection		= compileFinal preProcessFileLineNumbers "collisionDetection.sqf";
T_ambientCivilians			= compileFinal preProcessFileLineNumbers "ambientCivilians.sqf";
T_civBehavior				= compileFinal preProcessFileLineNumbers "civBehavior.sqf";
T_civMove					= compileFinal preProcessFileLineNumbers "civMove.sqf";
T_civSit					= compileFinal preProcessFileLineNumbers "civSit.sqf";
T_civBuildingSpawn			= compileFinal preProcessFileLineNumbers "civBuildingSpawn.sqf";
T_ambientDrivers			= compileFinal preProcessFileLineNumbers "ambientDrivers.sqf";
T_civDriving				= compileFinal preProcessFileLineNumbers "civDriving.sqf";
T_drugLabs					= compileFinal preProcessFileLineNumbers "drugLabs.sqf";
T_createPile				= compileFinal preProcessFileLineNumbers "createPile.sqf";
T_actionHolster				= compileFinal preProcessFileLineNumbers "actionHolster.sqf";

//INIT
_lieutenantController = [] spawn T_lieutenantController;
_escobarController = [] spawn T_escobarController;
//_actionHolster = [player] spawn T_actionHolster;
player setUnitTrait ["Engineer",true];

_ambientVehicles = [player] spawn T_ambientVehicles;

_groupCivs = createGroup Civilian;
//publicVariable "GrpCivs";
_ambientCivilians = [player, _groupCivs] spawn T_ambientCivilians;

_groupDrivers = createGroup [Civilian,false];
_ambientDrivers = [player, _groupDrivers] spawn T_ambientDrivers;

_drugLabs = [] call T_drugLabs;
_smugglingRoutes = [_drugLabs] spawn T_smugglingRoutes;

//MAIN 
//execVM "myLoop.sqf";









// Independent will not engage (unless fired upon)
// Blufor and Opfor will engage

// Squad Group Names and Factions
// Units will change faction depending on game/mission state
// DEA				grpDEA_B		(Blufor)
// CIA				grpCIA_B		(Blufor)
// Local Police		grpPolice_R		(Opfor)
// Local Police		grpPolice_B		(Blufor)
// Local Police		grpPolice_I		(Independent)
// National Police	grpCNP_R		(Opfor)
// National Police	grpCNP_B		(Blufor)
// National Police	grpCNP_I		(Independent)
// Search Bloc		grpSB_R			(Opfor)
// Search Bloc		grpSB_B			(Blufor)
// Search Bloc		grpSB_I			(Independent)
// Escobar			grpEscobar_R	(Opfor)
// Escobar			grpEscobar_I	(Independent)
// Civilians		grpCiv_R		(Opfor)
// Civilians		grpCiv_B		(Blufor)
// Civilians		grpCiv_I		(Independent)



// Escobar States
// Family Bond		Highly increases cartel loyalty and ability to escape raids. Increased by talking with or being near family
// Feared			Increased by performing terrorist/violent acts. Reduces betrayals, increases ability to escape raids
// Revered			Increased by helping the poor. Aligns civilian population to help, increases ability to escape raids
//						Reduced with violent acts. Provides intel on police activity.
//						Highly increases politico
// Money			Used to obtain new soldiers, vehicles, safehouses, execute bribes, upgrade infrastructure, provide donations
// Alliances		Determines how loyal other groups are to Escobar, could lead to betrayals or surprise help
// Wanted			Determines how law-enforcement groups will search for Escobar
// Immunity			Determines how law-enforcement will engage Escobar
// Legitimacy		Drastically reduces ability to run for political office if low. Increases immunity
// Narco			Drastically reduces legitimacy. Increases feared, money, and wanted
// Politico			Increased by making speeches. Drastrically increased if elected. 
//						Drastically increases legitimacy, alliances
//						Drastically reduces with any scandal
//						Reduced to zero with any known drug trafficking or terrorist acts


// DEA States
// Funding			Used for flights, buying information, vehicles/weapons/operations
// USA Support		Changes with US Presidential elections. Determines funding level and tolerance for scandals.
//						Drastically increases with DEA agent death
//						Determines what US-based resources are available to DEA
// USA Pressure		Increased with scandal or when non-cooperative with CIA. Changes with US elections. Reduces USA Support if too high
//						Determines what DEA agents are permitted to do
// COL Support		Columbian support of DEA activities in country. Determines what National police resources and intel are available to DEA
//						Increased with successful operations
// COL Pressure		Increased when terrorist/violent acts occur or scandals. Reduces COL Support if too high
//						Determines what DEA are permitted to do
// Reputation		Determines whether CI's provide correct intel, price of information, what CIs are available
// Scandal			Reduces USA Support. Increased when caught performing illegal/unethical actions			
// Immunity			Prevents cartel and other groups from engaging DEA agents. Reduced with scandal. Highly increased with DEA agent death


