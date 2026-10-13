--==========================================================================================================================
-- CONFIG DATA (front end): leader selection screen
-- Temporary art: portrait and icons are borrowed from LEADER_PETER_GREAT until the real art is cooked (ROADMAP phase 4).
--==========================================================================================================================
INSERT OR REPLACE INTO Players
		(Domain, CivilizationType, LeaderType, LeaderName, LeaderIcon, CivilizationName, CivilizationIcon, LeaderAbilityName, LeaderAbilityDescription, LeaderAbilityIcon, CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, Portrait, PortraitBackground)
SELECT	Domain, 'CIVILIZATION_RUSSIA', 'LEADER_REMSELY_ALEXANDER_II', 'LOC_LEADER_REMSELY_ALEXANDER_II_NAME', LeaderIcon, CivilizationName, CivilizationIcon, 'LOC_TRAIT_LEADER_REMSELY_ALEXANDER_II_REFORMS_NAME', 'LOC_TRAIT_LEADER_REMSELY_ALEXANDER_II_REFORMS_DESCRIPTION', LeaderAbilityIcon, CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, Portrait, PortraitBackground
FROM Players WHERE CivilizationType = 'CIVILIZATION_RUSSIA' AND LeaderType = 'LEADER_PETER_GREAT';

-- Unique items shown on the selection screen (copied from Peter)
INSERT OR REPLACE INTO PlayerItems
		(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex)
SELECT	Domain, CivilizationType, 'LEADER_REMSELY_ALEXANDER_II', Type, Icon, Name, Description, SortIndex
FROM PlayerItems WHERE CivilizationType = 'CIVILIZATION_RUSSIA' AND LeaderType = 'LEADER_PETER_GREAT';
