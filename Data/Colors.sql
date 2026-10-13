--==========================================================================================================================
-- COLORS: black / gold / ivory (Russian imperial)
--==========================================================================================================================
INSERT INTO Colors
		(Type, Color)
VALUES	('COLOR_PLAYER_REMSELY_ALEXANDER_II_PRIMARY',   '28,28,28,255'),
		('COLOR_PLAYER_REMSELY_ALEXANDER_II_SECONDARY', '212,160,23,255'),
		('COLOR_PLAYER_REMSELY_ALEXANDER_II_TEXT',      '245,241,230,255');

INSERT INTO PlayerColors
		(Type, Usage, PrimaryColor, SecondaryColor, TextColor)
VALUES	('LEADER_REMSELY_ALEXANDER_II', 'Unique', 'COLOR_PLAYER_REMSELY_ALEXANDER_II_PRIMARY', 'COLOR_PLAYER_REMSELY_ALEXANDER_II_SECONDARY', 'COLOR_PLAYER_REMSELY_ALEXANDER_II_TEXT');
