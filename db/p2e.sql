CREATE SCHEMA p2e;

CREATE TABLE p2e.AbilityType ( 
	AbilityType          varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

ALTER TABLE p2e.AbilityType MODIFY AbilityType varchar(100)  NOT NULL   COMMENT 'ancestry, background, class, choice';

CREATE TABLE p2e.ActionType ( 
	ActionType           varchar(100)  NOT NULL    PRIMARY KEY,
	MinSize              tinyint      ,
	MaxSize              tinyint      
 ) engine=InnoDB;

ALTER TABLE p2e.ActionType COMMENT 'free, reaction, action, activities';

ALTER TABLE p2e.ActionType MODIFY MinSize tinyint     COMMENT '0-2';

ALTER TABLE p2e.ActionType MODIFY MaxSize tinyint     COMMENT '0-3';

CREATE TABLE p2e.Alignment ( 
	AlignmentCode        varchar(2)  NOT NULL    PRIMARY KEY,
	Alignment            varchar(100)      
 ) engine=InnoDB;

ALTER TABLE p2e.Alignment COMMENT 'Lawful, Neutral, Choatic\nGood, Neutral, Evil';

ALTER TABLE p2e.Alignment MODIFY AlignmentCode varchar(2)  NOT NULL   COMMENT 'LG, LN, LE, NG, N, NE, CG, CN, CE';

CREATE TABLE p2e.Background ( 
	BackgroundId         int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	Background           varchar(100)      
 ) engine=InnoDB;

CREATE TABLE p2e.Campaign ( 
	Campaign             varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

CREATE TABLE p2e.Class ( 
	Class                varchar(100)  NOT NULL    PRIMARY KEY,
	SubClassDesc         varchar(100)      ,
	IsSpellcastingSpontaneous bit      ,
	IsSpellcastingPrepared bit      ,
	AddSkillFeatAllLevels bit      ,
	SkillBonus           varchar(500)      
 ) engine=InnoDB;

ALTER TABLE p2e.Class MODIFY SubClassDesc varchar(100)     COMMENT 'class-specific name for "sub-class"\nif null, does not apply';

ALTER TABLE p2e.Class MODIFY IsSpellcastingSpontaneous bit     COMMENT 'consider SpellcastingType';

ALTER TABLE p2e.Class MODIFY SkillBonus varchar(500)     COMMENT 'add more details';

CREATE TABLE p2e.Combat ( 
	CombatId             int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) engine=InnoDB;

CREATE TABLE p2e.CreatureType ( 
	CreatureType         varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

CREATE TABLE p2e.Deity ( 
	Deity                varchar(100)  NOT NULL    PRIMARY KEY,
	Alignment            varchar(2)  NOT NULL    ,
	EquipmentId          int UNSIGNED NOT NULL    ,
	IsHarm               bit      ,
	IsHeal               bit      ,
	DeityCategory        varchar(100)      
 ) engine=InnoDB;

ALTER TABLE p2e.Deity MODIFY Alignment varchar(2)  NOT NULL   COMMENT 'LG, LN, LE, NG, N, NE, CG, CN, CE';

ALTER TABLE p2e.Deity MODIFY EquipmentId int UNSIGNED NOT NULL   COMMENT 'favored weapon';

ALTER TABLE p2e.Deity MODIFY DeityCategory varchar(100)     COMMENT 'Gods of the Inner Sea, Demon Lords, etc';

CREATE TABLE p2e.Domain ( 
	Domain               varchar(100)  NOT NULL    PRIMARY KEY,
	DomainDesc           varchar(100)      
 ) engine=InnoDB;

CREATE TABLE p2e.EquipmentType ( 
	EquipmentType        varchar(100)  NOT NULL    PRIMARY KEY,
	IsEquipable          bit      ,
	EquipmentTraits      json      
 ) engine=InnoDB;

ALTER TABLE p2e.EquipmentType MODIFY EquipmentType varchar(100)  NOT NULL   COMMENT 'armor, shield, weapon, gear, alchemical item, consumable, held items, materials, runes, snares, staves, structures, wands, worn items';

CREATE TABLE p2e.FeatType ( 
	FeatType             varchar(100)  NOT NULL    PRIMARY KEY,
	IsGeneral            bit      ,
	CONSTRAINT Unq_Tbl_Feat_Type_FeatType UNIQUE ( FeatType ) 
 ) engine=InnoDB;

ALTER TABLE p2e.FeatType MODIFY FeatType varchar(100)  NOT NULL   COMMENT 'ancestry, archetype, class, skill, general';

ALTER TABLE p2e.FeatType MODIFY IsGeneral bit     COMMENT 'skill, general';

CREATE TABLE p2e.Hazard ( 
	Hazard               varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

CREATE TABLE p2e.Language ( 
	Language             varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

ALTER TABLE p2e.Language COMMENT 'can this be combined with Tbl_Skill?';

CREATE TABLE p2e.Party ( 
	PartyId              int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) engine=InnoDB;

CREATE TABLE p2e.Rarity ( 
	Rarity               varchar(100)  NOT NULL    PRIMARY KEY,
	RarityLevel          tinyint UNSIGNED NOT NULL    ,
	CONSTRAINT Unq_Rarity_RarityLevel UNIQUE ( RarityLevel ) 
 ) engine=InnoDB;

ALTER TABLE p2e.Rarity COMMENT 'merge into Trait?';

ALTER TABLE p2e.Rarity MODIFY Rarity varchar(100)  NOT NULL   COMMENT 'common, uncommon, rare, unique';

CREATE TABLE p2e.Skill ( 
	Skill                varchar(100)  NOT NULL    PRIMARY KEY,
	IsLore               bit      ,
	Campaign             varchar(100)      
 ) engine=InnoDB;

CREATE TABLE p2e.SpellLevel ( 
	SpellLevel           tinyint  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) engine=InnoDB;

ALTER TABLE p2e.SpellLevel COMMENT '1-10 = power';

CREATE TABLE p2e.SpellSchool ( 
	SpellSchool          varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

ALTER TABLE p2e.SpellSchool COMMENT '8 schools';

CREATE TABLE p2e.SpellTypeSpecial ( 
	SpellTypeSpecial     varchar(100)  NOT NULL    PRIMARY KEY,
	SpellTypeDesc        varchar(500)      
 ) engine=InnoDB;

ALTER TABLE p2e.SpellTypeSpecial MODIFY SpellTypeSpecial varchar(100)  NOT NULL   COMMENT '(regular), focus, innate, cantrip, ritual';

CREATE TABLE p2e.SpellcastingTradition ( 
	SpellcastingTradition varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

ALTER TABLE p2e.SpellcastingTradition COMMENT 'arcane, divine, occult, primal';

CREATE TABLE p2e.SubClass ( 
	SubClass             varchar(100)  NOT NULL    PRIMARY KEY,
	Class                varchar(100)  NOT NULL    ,
	RequiresAnimal       bit  NOT NULL DEFAULT 0   ,
	RequiresDragonType   bit  NOT NULL DEFAULT 0   ,
	RequiresDeity        bit  NOT NULL DEFAULT 0   
 ) engine=InnoDB;

ALTER TABLE p2e.SubClass COMMENT 'Bomber: Research Field\nBarbarian: Instinct (must pick Animal, Dragon Type/Color)\nBard: Muse\nChampion: Deity / Cause\nCleric: Deity / Doctrine\nDruid: Druidic Order\nHunter: Hunter''s Edge\nRogue: Rogue''s Racket\nSorcerer: Bloodline\nWizard: Arcane School\nFighter, Monk: none';

CREATE TABLE p2e.TraitType ( 
	TraitType            varchar(100)  NOT NULL    PRIMARY KEY
 ) engine=InnoDB;

ALTER TABLE p2e.TraitType COMMENT 'modify Equipment, Spells, Creatures';

ALTER TABLE p2e.TraitType MODIFY TraitType varchar(100)  NOT NULL   COMMENT 'school of magic, rules element, rarity, alignment, etc';

CREATE TABLE p2e.`User` ( 
	Email                varchar(150)  NOT NULL    ,
	UserId               int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CONSTRAINT Unq_Tbl_User UNIQUE ( Email ) 
 ) engine=InnoDB;

ALTER TABLE p2e.`User` MODIFY UserId int  NOT NULL  AUTO_INCREMENT COMMENT 'recommend uuid()';

CREATE TABLE p2e.AbilityCode ( 
	AbilityCode          char(3)  NOT NULL    PRIMARY KEY,
	Ability              varchar(100)      ,
	AbilityDesc          varchar(500)      ,
	AbilityType          varchar(100)  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.AbilityCode MODIFY AbilityCode char(3)  NOT NULL   COMMENT 'STR, DEX, CON, INT, WIS, CHA';

ALTER TABLE p2e.AbilityCode MODIFY AbilityType varchar(100)  NOT NULL   COMMENT 'ancestry, background, class, choice';

CREATE TABLE p2e.Action ( 
	Action               varchar(100)  NOT NULL    PRIMARY KEY,
	ActionType           varchar(100)  NOT NULL    ,
	Size                 tinyint  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.Action COMMENT 'Round consists of free action, 3 actions, + 1 reaction';

ALTER TABLE p2e.Action MODIFY Size tinyint  NOT NULL   COMMENT '0-3';

CREATE TABLE p2e.Campaign_Day ( 
	CampaignDay          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CampaignDisplayDate  date      ,
	Campaign             varchar(100)  NOT NULL    ,
	PartyId              int  NOT NULL    
 ) engine=InnoDB;

CREATE TABLE p2e.`Char` ( 
	CharId               int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharName             varchar(100)  NOT NULL    ,
	CreatureType         varchar(30)  NOT NULL DEFAULT 'Humanoid'   ,
	Ancestry             varchar(100)  NOT NULL    ,
	BackgroundId         int      ,
	Heritage             varchar(100)      ,
	Size                 varchar(20)   DEFAULT 'medium'   ,
	IsNpc                bit  NOT NULL DEFAULT 0   ,
	IsCreature           bit  NOT NULL DEFAULT 0   ,
	Deity                varchar(100)      ,
	Alignment            varchar(2)  NOT NULL    ,
	Rarity               varchar(100)  NOT NULL    ,
	Class                varchar(100)  NOT NULL    ,
	SubClass             varchar(100)      ,
	CreatureId           int      
 ) engine=InnoDB;

ALTER TABLE p2e.`Char` MODIFY CreatureType varchar(30)  NOT NULL DEFAULT 'Humanoid'  COMMENT 'Humanoid, Construct, Dragon';

ALTER TABLE p2e.`Char` MODIFY Alignment varchar(2)  NOT NULL   COMMENT 'LG, LN, LE, NG, N, NE, CG, CN, CE';

ALTER TABLE p2e.`Char` MODIFY Rarity varchar(100)  NOT NULL   COMMENT 'common, uncommon, rare, unique';

ALTER TABLE p2e.`Char` MODIFY CreatureId int     COMMENT 'animal familiar/companion';

CREATE TABLE p2e.Char_Ability ( 
	CharAbilityId        int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharId               int  NOT NULL    ,
	AbilityCode          char(3)  NOT NULL    ,
	AbilityType          varchar(100)  NOT NULL    ,
	AbilityScore         smallint UNSIGNED NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.Char_Ability COMMENT 'base ability when starting out\nancestry cannot mod base ability >12, <8\nlimit 2 background boost\nlimit 4 determine scores';

ALTER TABLE p2e.Char_Ability MODIFY AbilityCode char(3)  NOT NULL   COMMENT 'STR, DEX, CON, INT, WIS, CHA';

ALTER TABLE p2e.Char_Ability MODIFY AbilityType varchar(100)  NOT NULL   COMMENT 'ancestry, background, class, determine (choice)';

CREATE TABLE p2e.Char_Language ( 
	CharLanguageId       int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	Language             varchar(100)  NOT NULL    ,
	CharId               int  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.Char_Language COMMENT 'similar to Char_Skills\nlimited by Feat & Ancestry';

CREATE TABLE p2e.Combat_CharInitiative ( 
	CombatInitativeId    int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharId               int  NOT NULL    ,
	InitiativeTotal      int      ,
	CombatId             int  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.Combat_CharInitiative COMMENT 'how will creatures show?';

CREATE TABLE p2e.Deity_Domain ( 
	Deity                varchar(100)  NOT NULL    ,
	Domain               varchar(100)  NOT NULL    ,
	CONSTRAINT Pk_Deity_Domain PRIMARY KEY ( Deity, Domain )
 ) engine=InnoDB;

CREATE TABLE p2e.Equipment ( 
	EquipmentId          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	EquipmentName        varchar(100)      ,
	EquipmentType        varchar(100)  NOT NULL    ,
	BaseEquipmentId      int      ,
	IsTwoHanded          bit      
 ) engine=InnoDB;

ALTER TABLE p2e.Equipment MODIFY EquipmentType varchar(100)  NOT NULL   COMMENT 'armor, shield, weapon, gear, alchemical item, consumable, held items, materials, runes, snares, staves, structures, wands, worn items';

ALTER TABLE p2e.Equipment MODIFY BaseEquipmentId int     COMMENT 'if null, it''s a base equipment';

CREATE TABLE p2e.Feat ( 
	FeatId               int UNSIGNED NOT NULL    PRIMARY KEY,
	Feat                 varchar(100)  NOT NULL    ,
	FeatBonus            varchar(100)      ,
	FeatType             varchar(100)  NOT NULL    ,
	CONSTRAINT Unq_Feat_Feat UNIQUE ( Feat ) 
 ) engine=InnoDB;

ALTER TABLE p2e.Feat MODIFY FeatBonus varchar(100)     COMMENT 'TBD - boost, skill, etc';

ALTER TABLE p2e.Feat MODIFY FeatType varchar(100)  NOT NULL   COMMENT 'ancestry, archetype, class, skill, general';

CREATE TABLE p2e.Feat_AbilityReq ( 
	FeatId               int UNSIGNED NOT NULL    ,
	AbilityCode          char(3)  NOT NULL    ,
	MinAbilityScore      smallint UNSIGNED NOT NULL    ,
	CONSTRAINT Pk_Feat_AbilityReq PRIMARY KEY ( FeatId, AbilityCode )
 ) engine=InnoDB;

ALTER TABLE p2e.Feat_AbilityReq MODIFY AbilityCode char(3)  NOT NULL   COMMENT 'STR, DEX, CON, INT, WIS, CHA';

CREATE TABLE p2e.Feat_FeatReq ( 
	FeatId               int UNSIGNED NOT NULL    ,
	ReqFeatId            int UNSIGNED NOT NULL    ,
	CONSTRAINT Pk_Feat_FeatReq PRIMARY KEY ( FeatId, ReqFeatId )
 ) engine=InnoDB;

CREATE TABLE p2e.Feat_SkillReq ( 
	FeatSkillReqId       int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	FeatId               int  NOT NULL    ,
	Skill                varchar(100)      ,
	SkillProficiencyLevel int UNSIGNED     
 ) engine=InnoDB;

ALTER TABLE p2e.Feat_SkillReq MODIFY FeatId int  NOT NULL   COMMENT 'Paizo Id?';

CREATE TABLE p2e.Party_Char ( 
	PartyId              int  NOT NULL    ,
	CharId               int  NOT NULL    ,
	CONSTRAINT Pk_Party_Char PRIMARY KEY ( PartyId, CharId )
 ) engine=InnoDB;

CREATE TABLE p2e.Spell ( 
	SpellId              int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	SpellName            varchar(100)      ,
	SpellTypeSpecial     varchar(100)  NOT NULL    ,
	MinSpellLevel        tinyint  NOT NULL    ,
	SpellSchool          varchar(100)      ,
	SpellDesc            varchar(500)      ,
	LevelMultiplier      float      ,
	Benefits             json      
 ) engine=InnoDB;

ALTER TABLE p2e.Spell MODIFY SpellTypeSpecial varchar(100)  NOT NULL   COMMENT '(regular), focus, innate, cantrip, ritual';

ALTER TABLE p2e.Spell MODIFY LevelMultiplier float     COMMENT 'TBD';

ALTER TABLE p2e.Spell MODIFY Benefits json     COMMENT 'likely need separate table';

CREATE TABLE p2e.Spell_SpellcastingTradition ( 
	SpellcastingTradition varchar(100)  NOT NULL    ,
	SpellId              int  NOT NULL    ,
	CONSTRAINT Pk_Spell_SpellcastingTradition PRIMARY KEY ( SpellcastingTradition, SpellId )
 ) engine=InnoDB;

CREATE TABLE p2e.Trait ( 
	Trait                varchar(100)  NOT NULL    PRIMARY KEY,
	TraitType            varchar(100)  NOT NULL    ,
	TraitDesc            varchar(500)      
 ) engine=InnoDB;

ALTER TABLE p2e.Trait COMMENT 'rarity {common, uncommon, rare, unique}\nalignment {LG, N, etc}\nsize {tiny, small, medium, large, huge, gargantuan}\nother?';

ALTER TABLE p2e.Trait MODIFY TraitType varchar(100)  NOT NULL   COMMENT 'school of magic, rules element, rarity, alignment, size, creature type, etc';

CREATE TABLE p2e.User_Char ( 
	UserId               int  NOT NULL    ,
	CharId               int  NOT NULL    ,
	CONSTRAINT Pk_User_Char PRIMARY KEY ( UserId, CharId )
 ) engine=InnoDB;

ALTER TABLE p2e.User_Char MODIFY UserId int  NOT NULL   COMMENT 'recommend uuid()';

CREATE TABLE p2e.Ancestry ( 
	Ancestry             varchar(100)  NOT NULL    PRIMARY KEY,
	CreatureType         varchar(100)      ,
	Size                 varchar(100)      ,
	HpBonus              int      ,
	Speed                blob      ,
	Rarity               varchar(100)  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.Ancestry MODIFY Rarity varchar(100)  NOT NULL   COMMENT 'common, uncommon, rare, unique';

CREATE TABLE p2e.Ancestry_Ability ( 
	Ancestry             varchar(100)  NOT NULL    ,
	AbilityCode          char(3)  NOT NULL    ,
	BoostType            varchar(100)      ,
	BoostAmount          int      ,
	CONSTRAINT Pk_Ancestry_Ability PRIMARY KEY ( Ancestry, AbilityCode )
 ) engine=InnoDB;

ALTER TABLE p2e.Ancestry_Ability COMMENT 'more than one ability per ancestry\nspecified boost, specified flaw, free boost, taken flaw';

ALTER TABLE p2e.Ancestry_Ability MODIFY AbilityCode char(3)  NOT NULL   COMMENT 'STR, DEX, CON, INT, WIS, CHA';

ALTER TABLE p2e.Ancestry_Ability MODIFY BoostType varchar(100)     COMMENT 'specified boost, specified flaw, free boost, taken flaw';

CREATE TABLE p2e.Ancestry_Feat ( 
	FeatId               int  NOT NULL    ,
	Ancestry             varchar(100)  NOT NULL    ,
	CONSTRAINT Pk_Ancestry_Feat PRIMARY KEY ( FeatId, Ancestry )
 ) engine=InnoDB;

CREATE TABLE p2e.Ancestry_Language ( 
	Ancestry             varchar(100)  NOT NULL    ,
	Language             varchar(100)  NOT NULL    ,
	CONSTRAINT Pk_Ancestry_Language PRIMARY KEY ( Ancestry, Language )
 ) engine=InnoDB;

CREATE TABLE p2e.Char_Equipment ( 
	CharEquipmentId      int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharId               int  NOT NULL    ,
	EquipmentId          int  NOT NULL    ,
	IsEquipped           int      
 ) engine=InnoDB;

ALTER TABLE p2e.Char_Equipment COMMENT 'unique rules based on equipment\nchanging isequipped true may force other equipment isequipped false';

CREATE TABLE p2e.Char_SpellPrepared ( 
	CharSpellPreparedId  int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharId               int  NOT NULL    ,
	SpellId              int  NOT NULL    ,
	SpellLevel           tinyint  NOT NULL    ,
	PreparedNumber       int  NOT NULL DEFAULT 0   
 ) engine=InnoDB;

CREATE TABLE p2e.Char_SpellUsed ( 
	CharSpellUsedId      int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharId               int  NOT NULL    ,
	SpellId              int  NOT NULL    ,
	SpellLevel           tinyint  NOT NULL    ,
	UsedNumber           int  NOT NULL DEFAULT 0   ,
	ResetDatetime        datetime(0)      
 ) engine=InnoDB;

ALTER TABLE p2e.Char_SpellUsed COMMENT 'for spontaneous or prepared';

CREATE TABLE p2e.Char_Trait ( 
	CharTraitId          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharId               int  NOT NULL    ,
	Trait                varchar(100)  NOT NULL    ,
	TraitType            varchar(100)  NOT NULL    ,
	CONSTRAINT Unq_Tbl_Char_Trait UNIQUE ( CharId, TraitType ) 
 ) engine=InnoDB;

ALTER TABLE p2e.Char_Trait COMMENT 'alternative to storing denormalized';

ALTER TABLE p2e.Char_Trait MODIFY TraitType varchar(100)  NOT NULL   COMMENT 'school of magic, rules element, rarity, alignment, etc';

CREATE TABLE p2e.ClassArchetype_Feat ( 
	FeatId               int  NOT NULL    ,
	ClassArchetype       varchar(100)  NOT NULL    ,
	CONSTRAINT Pk_ClassArchetype_Feat PRIMARY KEY ( FeatId, ClassArchetype )
 ) engine=InnoDB;

ALTER TABLE p2e.ClassArchetype_Feat MODIFY FeatId int  NOT NULL   COMMENT 'Paizo Id?';

CREATE TABLE p2e.Class_Spell ( 
	Class                varchar(100)  NOT NULL    ,
	SpellId              int  NOT NULL    ,
	CONSTRAINT Pk_Class_Spell PRIMARY KEY ( Class, SpellId )
 ) engine=InnoDB;

CREATE TABLE p2e.Equipment_Trait ( 
	EquipmentId          int  NOT NULL    ,
	Trait                varchar(100)  NOT NULL    ,
	CONSTRAINT Pk_Equipment_Trait PRIMARY KEY ( EquipmentId, Trait )
 ) engine=InnoDB;

CREATE TABLE p2e.SpellTrait ( 
	SpellTraitId         int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	SpellId              int  NOT NULL    ,
	Trait                varchar(100)  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.SpellTrait COMMENT 'alternative or supporting table for normalized traits';

CREATE TABLE p2e.Action_SkillReq ( 
	Action               varchar(100)  NOT NULL    ,
	Skill                varchar(100)  NOT NULL    ,
	SkillProficiencyLevel tinyint  NOT NULL    ,
	CONSTRAINT Pk_Action_SkillReq PRIMARY KEY ( Action, Skill )
 ) engine=InnoDB;

ALTER TABLE p2e.Action_SkillReq MODIFY SkillProficiencyLevel tinyint  NOT NULL   COMMENT '1-5';

CREATE TABLE p2e.CharLevel ( 
	CharLevel            tinyint UNSIGNED NOT NULL DEFAULT 1   PRIMARY KEY,
	AddAncestryFeat      bit      ,
	AddSkillFeat         bit      
 ) engine=InnoDB;

ALTER TABLE p2e.CharLevel COMMENT '1-20\nancestry feats at 1,5,9,13,17\nskill feat every 2nd level\nfocus points (1/2 levels rounded up)\nsome class have extra skill feat every level (tracked on Class)';

ALTER TABLE p2e.CharLevel MODIFY CharLevel tinyint UNSIGNED NOT NULL DEFAULT 1  COMMENT '1-20';

CREATE TABLE p2e.Char_LevelUp ( 
	CharLevelUpId        int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharId               int  NOT NULL    ,
	CharLevel            tinyint UNSIGNED NOT NULL DEFAULT 1   ,
	BonusAbilityCode     int      ,
	Class                varchar(100)  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.Char_LevelUp MODIFY CharLevel tinyint UNSIGNED NOT NULL DEFAULT 1  COMMENT '1-20';

CREATE TABLE p2e.Char_LevelUp_Feat ( 
	CharLevelFeatId      int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CharLevelUpId        int  NOT NULL    ,
	FeatId               int  NOT NULL    
 ) engine=InnoDB;

ALTER TABLE p2e.Char_LevelUp_Feat COMMENT 'can have more than one feat per level\ncan sub skill feat for general feat';

ALTER TABLE p2e.Char_LevelUp_Feat MODIFY FeatId int  NOT NULL   COMMENT 'Paizo Id?';

CREATE TABLE p2e.SkillProficiency ( 
	SkillProficiencyLevel tinyint  NOT NULL    PRIMARY KEY,
	SkillProficiency     varchar(100)  NOT NULL    ,
	MinCharLevel         tinyint  NOT NULL DEFAULT 1   
 ) engine=InnoDB;

ALTER TABLE p2e.SkillProficiency MODIFY SkillProficiencyLevel tinyint  NOT NULL   COMMENT '1-5';

ALTER TABLE p2e.SkillProficiency MODIFY SkillProficiency varchar(100)  NOT NULL   COMMENT 'untrained, trained, expert, master, legendary';

ALTER TABLE p2e.SkillProficiency MODIFY MinCharLevel tinyint  NOT NULL DEFAULT 1  COMMENT '1 for untrained, 1 for trained, 1 for expert, 7 for master, 15 for legendary';

ALTER TABLE p2e.AbilityCode ADD CONSTRAINT Fk_Tbl_Ability_Tbl_Ability_Type FOREIGN KEY ( AbilityType ) REFERENCES p2e.AbilityType( AbilityType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Action ADD CONSTRAINT Fk_Tbl_Action_Tbl_Action_Type FOREIGN KEY ( ActionType ) REFERENCES p2e.ActionType( ActionType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Action_SkillReq ADD CONSTRAINT Fk_Tbl_Action_Req_Skill_Tbl_Action FOREIGN KEY ( Action ) REFERENCES p2e.Action( Action ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Action_SkillReq ADD CONSTRAINT Fk_Tbl_Action_Req_Skill_Tbl_Skill FOREIGN KEY ( Skill ) REFERENCES p2e.Skill( Skill ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Action_SkillReq ADD CONSTRAINT Fk_Tbl_Action_Req_Skill_Tbl_Skill_Proficiency FOREIGN KEY ( SkillProficiencyLevel ) REFERENCES p2e.SkillProficiency( SkillProficiencyLevel ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry ADD CONSTRAINT Fk_Tbl_Ancestry_Tbl_Trait FOREIGN KEY ( Ancestry ) REFERENCES p2e.Trait( Trait ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry ADD CONSTRAINT Fk_Ancestry_Rarity FOREIGN KEY ( Rarity ) REFERENCES p2e.Rarity( Rarity ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry_Ability ADD CONSTRAINT Fk_Tbl_Ancestry_Ability_Tbl_Ability FOREIGN KEY ( AbilityCode ) REFERENCES p2e.AbilityCode( AbilityCode ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry_Ability ADD CONSTRAINT Fk_Tbl_Ancestry_Ability_Tbl_Ancestry FOREIGN KEY ( Ancestry ) REFERENCES p2e.Ancestry( Ancestry ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry_Feat ADD CONSTRAINT Fk_Tbl_Ancestry_Feat_Tbl_Feat FOREIGN KEY ( FeatId ) REFERENCES p2e.Feat( FeatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry_Feat ADD CONSTRAINT Fk_Tbl_Ancestry_Feat_Tbl_Ancestry FOREIGN KEY ( Ancestry ) REFERENCES p2e.Ancestry( Ancestry ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry_Language ADD CONSTRAINT Fk_Tbl_Ancestry_Language_Tbl_Ancestry FOREIGN KEY ( Ancestry ) REFERENCES p2e.Ancestry( Ancestry ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Ancestry_Language ADD CONSTRAINT Fk_Tbl_Ancestry_Language_Tbl_Language FOREIGN KEY ( Language ) REFERENCES p2e.Language( Language ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Campaign_Day ADD CONSTRAINT Fk_Tbl_Campaign_Day_Tbl_Campaign FOREIGN KEY ( Campaign ) REFERENCES p2e.Campaign( Campaign ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Campaign_Day ADD CONSTRAINT Fk_Tbl_Campaign_Day_Tbl_Party FOREIGN KEY ( PartyId ) REFERENCES p2e.Party( PartyId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.`Char` ADD CONSTRAINT Fk_Tbl_Char_Tbl_Deity FOREIGN KEY ( Deity ) REFERENCES p2e.Deity( Deity ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.`Char` ADD CONSTRAINT Fk_Tbl_Char_Tbl_Alignment FOREIGN KEY ( Alignment ) REFERENCES p2e.Alignment( AlignmentCode ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.`Char` ADD CONSTRAINT Fk_Char_Rarity FOREIGN KEY ( Rarity ) REFERENCES p2e.Rarity( Rarity ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.`Char` ADD CONSTRAINT Fk_Char_Background FOREIGN KEY ( BackgroundId ) REFERENCES p2e.Background( BackgroundId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.`Char` ADD CONSTRAINT Fk_Char_Class FOREIGN KEY ( Class ) REFERENCES p2e.Class( Class ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.`Char` ADD CONSTRAINT Fk_Char_SubClass FOREIGN KEY ( SubClass ) REFERENCES p2e.SubClass( SubClass ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.`Char` ADD CONSTRAINT Fk_Char_CreatureType FOREIGN KEY ( CreatureType ) REFERENCES p2e.CreatureType( CreatureType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.CharLevel ADD CONSTRAINT Fk_Tbl_Level_Tbl_Skill_Proficiency FOREIGN KEY ( CharLevel ) REFERENCES p2e.SkillProficiency( MinCharLevel ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Ability ADD CONSTRAINT Fk_Tbl_Char_Ability_Tbl_Ability FOREIGN KEY ( AbilityCode ) REFERENCES p2e.AbilityCode( AbilityCode ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Ability ADD CONSTRAINT Fk_Tbl_Char_Ability_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Ability ADD CONSTRAINT Fk_Tbl_Char_Ability_Tbl_Ability_Type FOREIGN KEY ( AbilityType ) REFERENCES p2e.AbilityType( AbilityType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Equipment ADD CONSTRAINT Fk_Tbl_Char_Equipment_Tbl_Equipment FOREIGN KEY ( EquipmentId ) REFERENCES p2e.Equipment( EquipmentId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Equipment ADD CONSTRAINT Fk_Char_Equipment_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Language ADD CONSTRAINT Fk_Tbl_Char_Language_Tbl_Language FOREIGN KEY ( Language ) REFERENCES p2e.Language( Language ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Language ADD CONSTRAINT Fk_Tbl_Char_Language_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_LevelUp ADD CONSTRAINT Fk_Tbl_Char_Level_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_LevelUp ADD CONSTRAINT Fk_Tbl_Char_Level_Tbl_Level FOREIGN KEY ( CharLevel ) REFERENCES p2e.CharLevel( CharLevel ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_LevelUp ADD CONSTRAINT Fk_Char_LevelUp_Class FOREIGN KEY ( Class ) REFERENCES p2e.Class( Class ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_LevelUp_Feat ADD CONSTRAINT Fk_Tbl_Char_Level_Feat_Tbl_Char_Level FOREIGN KEY ( CharLevelUpId ) REFERENCES p2e.Char_LevelUp( CharLevelUpId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_LevelUp_Feat ADD CONSTRAINT Fk_Tbl_Char_Level_Feat_Tbl_Feat FOREIGN KEY ( FeatId ) REFERENCES p2e.Feat( FeatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_SpellPrepared ADD CONSTRAINT Fk_Tbl_Char_Spell_Prepared_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_SpellPrepared ADD CONSTRAINT Fk_Tbl_Char_Spell_Prepared_Tbl_Spell FOREIGN KEY ( SpellId ) REFERENCES p2e.Spell( SpellId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_SpellPrepared ADD CONSTRAINT Fk_Tbl_Char_Spell_Prepared_Tbl_Spell_Level FOREIGN KEY ( SpellLevel ) REFERENCES p2e.SpellLevel( SpellLevel ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_SpellUsed ADD CONSTRAINT Fk_Tbl_Char_Spell_Spontaneous_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_SpellUsed ADD CONSTRAINT Fk_Tbl_Char_Spell_Spontaneous_Tbl_Spell FOREIGN KEY ( SpellId ) REFERENCES p2e.Spell( SpellId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_SpellUsed ADD CONSTRAINT Fk_Tbl_Char_Spell_Used_Tbl_Spell_Level FOREIGN KEY ( SpellLevel ) REFERENCES p2e.SpellLevel( SpellLevel ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Trait ADD CONSTRAINT Fk_Tbl_Char_Trait_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Trait ADD CONSTRAINT Fk_Tbl_Char_Trait_Tbl_Trait FOREIGN KEY ( Trait ) REFERENCES p2e.Trait( Trait ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Char_Trait ADD CONSTRAINT Fk_Tbl_Char_Trait_Tbl_Trait_Type FOREIGN KEY ( TraitType ) REFERENCES p2e.TraitType( TraitType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.ClassArchetype_Feat ADD CONSTRAINT Fk_Tbl_Archetype_Feat_Tbl_Feat FOREIGN KEY ( FeatId ) REFERENCES p2e.Feat( FeatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.ClassArchetype_Feat ADD CONSTRAINT Fk_ClassArchetype_Feat_Class FOREIGN KEY ( ClassArchetype ) REFERENCES p2e.Class( Class ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Class_Spell ADD CONSTRAINT Fk_Tbl_Class_Spell_Tbl_Class FOREIGN KEY ( Class ) REFERENCES p2e.Class( Class ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Class_Spell ADD CONSTRAINT Fk_Tbl_Class_Spell_Tbl_Spell FOREIGN KEY ( SpellId ) REFERENCES p2e.Spell( SpellId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Combat_CharInitiative ADD CONSTRAINT Fk_Tbl_Session_Initiative_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Combat_CharInitiative ADD CONSTRAINT Fk_Tbl_Combat_Initiative_Tbl_Combat FOREIGN KEY ( CombatId ) REFERENCES p2e.Combat( CombatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Deity ADD CONSTRAINT Fk_Tbl_Deity_Tbl_Alignment FOREIGN KEY ( Alignment ) REFERENCES p2e.Alignment( AlignmentCode ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Deity_Domain ADD CONSTRAINT Fk_Deity_Domain_Deity FOREIGN KEY ( Deity ) REFERENCES p2e.Deity( Deity ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Deity_Domain ADD CONSTRAINT Fk_Deity_Domain_Domain FOREIGN KEY ( Domain ) REFERENCES p2e.Domain( Domain ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Equipment ADD CONSTRAINT Fk_Equipment_EquipmentType FOREIGN KEY ( EquipmentType ) REFERENCES p2e.EquipmentType( EquipmentType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Equipment ADD CONSTRAINT Fk_Equipment_BaseEquipment FOREIGN KEY ( BaseEquipmentId ) REFERENCES p2e.Equipment( EquipmentId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Equipment_Trait ADD CONSTRAINT Fk_EquipmentTrait_Equipment FOREIGN KEY ( EquipmentId ) REFERENCES p2e.Equipment( EquipmentId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Equipment_Trait ADD CONSTRAINT Fk_EquipmentTrait_Trait FOREIGN KEY ( Trait ) REFERENCES p2e.Trait( Trait ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Feat ADD CONSTRAINT Fk_Tbl_Feat_Tbl_Feat_Type FOREIGN KEY ( FeatType ) REFERENCES p2e.FeatType( FeatType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Feat_AbilityReq ADD CONSTRAINT Fk_Feat_AttributeReq_Feat FOREIGN KEY ( FeatId ) REFERENCES p2e.Feat( FeatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Feat_AbilityReq ADD CONSTRAINT Fk_Feat_AttributeReq_AbilityCode FOREIGN KEY ( AbilityCode ) REFERENCES p2e.AbilityCode( AbilityCode ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Feat_FeatReq ADD CONSTRAINT Fk_FeatReq_ReqFeat FOREIGN KEY ( ReqFeatId ) REFERENCES p2e.Feat( FeatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Feat_FeatReq ADD CONSTRAINT Fk_FeatReq_Feat FOREIGN KEY ( FeatId ) REFERENCES p2e.Feat( FeatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Feat_SkillReq ADD CONSTRAINT Fk_Tbl_Feat_Prereq_Tbl_Feat FOREIGN KEY ( FeatId ) REFERENCES p2e.Feat( FeatId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Party_Char ADD CONSTRAINT Fk_Tbl_Party_Char_Tbl_Party FOREIGN KEY ( PartyId ) REFERENCES p2e.Party( PartyId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Party_Char ADD CONSTRAINT Fk_Tbl_Party_Char_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Skill ADD CONSTRAINT Fk_Tbl_Skill_Tbl_Campaign FOREIGN KEY ( Campaign ) REFERENCES p2e.Campaign( Campaign ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.SkillProficiency ADD CONSTRAINT Fk_Tbl_Skill_Proficiency_Tbl_Level FOREIGN KEY ( MinCharLevel ) REFERENCES p2e.CharLevel( CharLevel ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Spell ADD CONSTRAINT Fk_Tbl_Spell_Tbl_Spell_School FOREIGN KEY ( SpellSchool ) REFERENCES p2e.SpellSchool( SpellSchool ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Spell ADD CONSTRAINT Fk_Tbl_Spell_Tbl_Spell_Type_Special FOREIGN KEY ( SpellTypeSpecial ) REFERENCES p2e.SpellTypeSpecial( SpellTypeSpecial ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Spell ADD CONSTRAINT Fk_Tbl_Spell_Tbl_Spell_Level FOREIGN KEY ( MinSpellLevel ) REFERENCES p2e.SpellLevel( SpellLevel ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.SpellTrait ADD CONSTRAINT Fk_Tbl_Spell_Trait_Tbl_Spell FOREIGN KEY ( SpellId ) REFERENCES p2e.Spell( SpellId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.SpellTrait ADD CONSTRAINT Fk_Tbl_Spell_Trait_Tbl_Trait FOREIGN KEY ( Trait ) REFERENCES p2e.Trait( Trait ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Spell_SpellcastingTradition ADD CONSTRAINT Fk_Tbl_Spellcasting_Tradition_Spell_Tbl_Spellcasting_Tradition FOREIGN KEY ( SpellcastingTradition ) REFERENCES p2e.SpellcastingTradition( SpellcastingTradition ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Spell_SpellcastingTradition ADD CONSTRAINT Fk_Tbl_Spellcasting_Tradition_Spell_Tbl_Spell FOREIGN KEY ( SpellId ) REFERENCES p2e.Spell( SpellId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.SubClass ADD CONSTRAINT Fk_Tbl_Sub_Class_Tbl_Class FOREIGN KEY ( Class ) REFERENCES p2e.Class( Class ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Trait ADD CONSTRAINT Fk_Tbl_Trait_Tbl_Trait_Type FOREIGN KEY ( TraitType ) REFERENCES p2e.TraitType( TraitType ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.Trait ADD CONSTRAINT Fk_Tbl_Trait_Tbl_Rarity FOREIGN KEY ( Trait ) REFERENCES p2e.Rarity( Rarity ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.User_Char ADD CONSTRAINT Fk_Tbl_User_Char_Tbl_User FOREIGN KEY ( UserId ) REFERENCES p2e.`User`( UserId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE p2e.User_Char ADD CONSTRAINT Fk_Tbl_User_Char_Tbl_Char FOREIGN KEY ( CharId ) REFERENCES p2e.`Char`( CharId ) ON DELETE NO ACTION ON UPDATE NO ACTION;

