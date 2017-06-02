//-----------------------------------
// MOURNS-FOR-TREES
// - Can teach you to become a Priest after encountering him during Mebbeth's quest. 
//-----------------------------------
APPEND DMFTREE 

	IF ~~ THEN BEGIN qd_pob_priest
		SAY @2
		++ @3 DO ~SetGlobal("QD_Priest_Training","GLOBAL",1) CreateCreature("qd_f2p",[0.0],S)~ EXIT 
	END 

	/*
	IF ~~ THEN BEGIN qd_pob_nature
		SAY ~He nods. "Much like how your belief in these trees caused them to regenerate, *belief* in the natural world as a whole can sprout new growth from desolate soil."~
	END 
	*/
END 

EXTEND_BOTTOM DMFTREE 28 #1
	+ ~Global("Mourns","GLOBAL",3) GlobalGT("Mebbeth_Quest","GLOBAL",2) !Class(Protagonist,CLERIC)~ + @4 + qd_pob_priest  
	// + ~ False() Global("Mourns","GLOBAL",3) Global("Mourns_Quest","AR0400",2) Class(Protagonist,CLERIC)~ + ~"Could you show me the the power of your *beliefs*?"~ + qd_pob_nature 
END 

//-----------------------------------
// AOLA
// - Can teach you to become a Priest by becoming a Discipline of Aoskar. 
//-----------------------------------
ALTER_TRANS DAOLA 
	BEGIN 12 END 
	BEGIN 0 END 
BEGIN 
	"ACTION" ~SetGlobal("Shutup","Global",1)
			SetGlobal("Lady","Global",50)
			SetGlobal("Disciple","Global",1)
			SetGlobal("DMaze","Global",1)
			SetGlobal("QD_Priest_Training","GLOBAL",1)
			CreateCreature("qd_f2p",[0.0],S)~   
END 

//-----------------------------------
// FALL-FROM-GRACE
// - Can retrain you to become a Priest after learning from MFT. 
//-----------------------------------
APPEND DGRACE 

	IF ~~ THEN BEGIN qd_pob_grace_priest
		SAY @5 
		++ @6 DO ~CreateCreature("qd_f2p",[0.0],S)~ EXIT 
	END 

END 

EXTEND_BOTTOM DGRACE 139 #5
	+ ~Global("QD_Priest_Training","GLOBAL",1) !Class(Protagonist,CLERIC)~ + @7 + qd_pob_grace_priest  
END 

//-----------------------------------
// PILLAR of SKULLS 
// - Adding Priest specialization option to save Morte.
//-----------------------------------
APPEND DPILLAR 

	IF ~~ THEN BEGIN qd_pillar_morte_priest
		SAY @9 
		++ #53602 DO ~PermanentStatChange(Protagonist,MAXHITPOINTS,LOWER,5) StartCutSceneMode() StartCutSceneEx("1001Cut3",FALSE)~ EXIT 
	END 

END

ALTER_TRANS DPILLAR 
	BEGIN 57 END 
	BEGIN 3 END 
BEGIN 
	"TRIGGER" ~!Global("Specialist","GLOBAL",4)
			!Global("Specialist","GLOBAL",5)
			!Global("Specialist","GLOBAL",6)
			!Global("QD_PRIEST_SPEC_12","GLOBAL",1)
			HPGT(Protagonist,10)~  
END 

ALTER_TRANS DPILLAR 
	BEGIN 57 END 
	BEGIN 4 END 
BEGIN 
	"TRIGGER" ~!Global("Specialist","GLOBAL",4)
			!Global("Specialist","GLOBAL",5)
			!Global("Specialist","GLOBAL",6)
			!Global("QD_PRIEST_SPEC_12","GLOBAL",1)
			HPLT(Protagonist,11)~  
END 

EXTEND_BOTTOM DPILLAR 57 #3 
	+ ~Global("QD_PRIEST_SPEC_12","GLOBAL",1)~ + @8 DO ~SetGlobal("Pillar","GLOBAL",4)~ + qd_pillar_morte_priest
END 
	
//add priest to the pillar check for no specialization
ALTER_TRANS DMORTE 
	BEGIN 529 END 
	BEGIN 3 END 
BEGIN 
	"TRIGGER" ~!Global("Specialist","GLOBAL",4)
			!Global("Specialist","GLOBAL",5)
			!Global("Specialist","GLOBAL",6)
			!Global("QD_PRIEST_SPEC_12","GLOBAL",1)~  
END 

//add priest to morte's checks in the dialog about being put into the pillar
EXTEND_BOTTOM DMORTE 529 #7
	+ ~Global("QD_PRIEST_SPEC_12","GLOBAL",1)~ + #53834 + 530
END 

//-----------------------------------
// MANY-AS-ONE
// - Adding Priest check to Kyton revelation after completion of MAO quest. 
//-----------------------------------
APPEND DMANYAS1 

	IF ~~ THEN BEGIN qd_kyton_revelation
		SAY @18
		++ @17 DO ~GiveExperience(Protagonist,1000)~ + 19 
	END 

END

EXTEND_BOTTOM DMANYAS1 17 #0 
	+ ~Class(Protagonist,CLERIC)~ + @17 DO ~GiveExperience(Protagonist,1000)~ + qd_kyton_revelation
END 

EXTEND_BOTTOM DMANYAS1 64 #0 
	+ ~Class(Protagonist,CLERIC)~ + @24 + 68
END 

//-----------------------------------
// NABAT
// - Adding Priest check to Thief training dialog.
//-----------------------------------
EXTEND_BOTTOM DNABAT 21 #1
	+ ~Class(Protagonist,CLERIC)~ + @19 DO ~FadeToColor([20.0],0) Wait(2) FadeFromColor([20.0],0) SetNamelessClass(THIEF)~ + 22
END 

//-----------------------------------
// THORNCOMBE
// - Adding Priest check to Mage training dialog.
//-----------------------------------
EXTEND_BOTTOM DTHORNCO 32 #1
	+ ~Class(Protagonist,CLERIC) GlobalGT("Mage_Training","GLOBAL",0)~ + @20 + 33
	+ ~Class(Protagonist,CLERIC) Global("Mage_Training","GLOBAL",0)~ + @21 + 36
END 

//-----------------------------------
// ELI
// - Adding Priest check to Thief training dialog.
//-----------------------------------
EXTEND_BOTTOM DELI 46 #1
	+ ~Class(Protagonist,CLERIC)~ + @22 + 47
END 

//-----------------------------------
// QUI-SAI
// - Adding Priest check to Warrior training dialog.
//-----------------------------------
EXTEND_BOTTOM DQUISAI 50 #2
	+ ~Class(Protagonist,CLERIC)~ + @23 DO ~FadeToColor([20.0],0) Wait(3) FadeFromColor([20.0],0) CreateCreature("qd_p2f",[0.0],SSW)~ + 37
END 

//-----------------------------------
// ANNAH
// - Adding Priest check to Thief training dialog.
//-----------------------------------
EXTEND_BOTTOM DANNAH 322 #3
	+ ~Class(Protagonist,CLERIC) GlobalGT("Thief_Training","GLOBAL",0)~ + @25 + 325
	+ ~Class(Protagonist,CLERIC) Global("Thief_Training","GLOBAL",0)~ + @26 + 36
END 

//-----------------------------------
// PORPHIRON
// - Adding Priest check to Warrior training dialog.
//-----------------------------------
EXTEND_BOTTOM DPORPHIR 32 #1
	+ ~Class(Protagonist,CLERIC)~ + @27 + 33
END 

//-----------------------------------
// RATPR Patches
// - Replace all Fighter training with the updated Fighter training creature. 
//-----------------------------------
R_A_T_P_R ~.*~ ~SetNamelessClass(FIGHTER)~ ~CreateCreature("qd_p2f",[0.0],1)~
