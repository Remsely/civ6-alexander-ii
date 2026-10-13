# Русские термины

Источник: `reference/game-db/DebugLocalization.sqlite` (`ru_RU`) и `Vanilla_ru_RU.xml` / `Expansion*_Translations_*.xml`.
Буква «ё» не используется (так же, как в официальном тексте). Форму записи падежей и опыт перевода см. в репозитории `civ6-leaders-mods-ru-localization` (`docs/TRANSLATION_GUIDE.md`).

## Падежи у названий

Теги `LOC_{LEADER,UNIT,BUILDING,DISTRICT,IMPROVEMENT,CIVILIZATION}_*_NAME` пишутся шестью формами через `|` (именительный, родительный, дательный, винительный, творительный, предложный) и с `<Gender>` / `<Plurality>`. Остальные тексты (способности, повестки, описания) — обычные строки.

## Эпохи (`LOC_ERA_*_NAME`)

| Эпоха | Русское название |
|---|---|
| Ancient | Древний мир |
| Classical | Античность |
| Medieval | Средневековье |
| Renaissance | Возрождение |
| Industrial | Промышленная эра |
| Modern | Новое время |
| Atomic | Эпоха атома |
| Information | Информационная эра |
| Future (только Gathering Storm) | Эпоха будущего |

Названия эпох, которые есть в `Eras`, нужны для «Земств» (9 ступеней в GS, 8 без него). Название эпохи «Будущее» лежит только в `Expansion2_Translations_ConfigText.xml`, в `DebugLocalization.sqlite` его нет.

## Игровые сущности

| Понятие | Русское название | Тег |
|---|---|---|
| Пастбище | Пастбище | `LOC_IMPROVEMENT_PASTURE_NAME` |
| Ферма | Ферма | `LOC_IMPROVEMENT_FARM_NAME` |
| Строитель | Строители (так записан тег с падежами) | `LOC_UNIT_BUILDER_NAME` |
| Россия | Россия | `LOC_CIVILIZATION_RUSSIA_NAME` |
| Петр Великий | Петр Великий (без «ё») | `LOC_LEADER_PETER_GREAT_NAME` |
| Профессиональная армия (политика) | **Продвинутая армия** | `LOC_POLICY_PROFESSIONAL_ARMY_NAME` |
| Губернатор | Губернатор | `LOC_RELIC_GOVERNOR` и теги `LOC_GOVERNOR_*` |
| Лояльность | лояльность, «ед. лояльности» | см. `LOC_CIVILIZATION_PRESLAV_BONUS_XP1` |

Важно для дизайн-документа: политика, которую ты в роадмапе называешь «Профессиональная армия», в русской игре называется **«Продвинутая армия»**.
