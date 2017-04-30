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
// RATPR Patches
// - Replace all Fighter training with the updated Fighter training creature. 
//-----------------------------------
R_A_T_P_R ~.*~ ~SetNamelessClass(FIGHTER)~ ~CreateCreature("qd_p2f",[0.0],1)~
