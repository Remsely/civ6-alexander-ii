--==========================================================================================================================
-- LEADER: Remsely's Alexander II (phase 2: playable stub, no gameplay effects yet)
--==========================================================================================================================
INSERT INTO Types (Type, Kind) VALUES
		('LEADER_REMSELY_ALEXANDER_II',  'KIND_LEADER'),
		('TRAIT_LEADER_REMSELY_ZEMSTVO', 'KIND_TRAIT');

INSERT INTO Leaders (LeaderType, Name, Sex, InheritFrom, SceneLayers) VALUES
		('LEADER_REMSELY_ALEXANDER_II', 'LOC_LEADER_REMSELY_ALEXANDER_II_NAME', 'Male', 'LEADER_DEFAULT', 4);

-- Placeholder leader ability; modifiers are added in phase 3
INSERT INTO Traits (TraitType, Name, Description) VALUES
		('TRAIT_LEADER_REMSELY_ZEMSTVO', 'LOC_TRAIT_LEADER_REMSELY_ZEMSTVO_NAME', 'LOC_TRAIT_LEADER_REMSELY_ZEMSTVO_DESCRIPTION');

INSERT INTO LeaderTraits (LeaderType, TraitType) VALUES
		('LEADER_REMSELY_ALEXANDER_II', 'TRAIT_LEADER_REMSELY_ZEMSTVO');

-- Temporary art: Peter's loading screen
INSERT INTO LoadingInfo (LeaderType, ForegroundImage, BackgroundImage, PlayDawnOfManAudio) VALUES
		('LEADER_REMSELY_ALEXANDER_II', 'LEADER_PETER_GREAT_NEUTRAL', 'LEADER_PETER_GREAT_BACKGROUND', 0);

INSERT INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName) VALUES
		('CIVILIZATION_RUSSIA', 'LEADER_REMSELY_ALEXANDER_II', 'LOC_CITY_NAME_MOSCOW');
