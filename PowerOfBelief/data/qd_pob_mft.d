//Mourns-for-Trees can teach you to become a Priest. 
APPEND DMFTREE 

IF ~~ THEN BEGIN qd_pob_priest
	SAY @2
	++ @3 DO ~SetGlobal("QD_Priest_Training","GLOBAL",1) CreateCreature("qd_f2p")~ EXIT 
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

//Fall-from-Grace can teach you after you've learned from MFT. 

APPEND DGRACE 

IF ~~ THEN BEGIN qd_pob_grace_priest
	SAY @5 
	++ @6 DO ~CreateCreature("qd_f2p")~ EXIT 
END 

END 

EXTEND_BOTTOM DGRACE 139 #5
	+ ~Global("QD_Priest_Training","GLOBAL",1) !Class(Protagonist,CLERIC)~ + @7 + qd_pob_grace_priest  
END 


R_A_T_P_R ~.*~ ~SetNamelessClass(FIGHTER)~ ~CreateCreature("qd_p2f",[0.0],S)~