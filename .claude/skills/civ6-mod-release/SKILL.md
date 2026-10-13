---
name: civ6-mod-release
description: Выпуск мода Civilization VI: архив для GitHub Releases, версия, CHANGELOG, описание, превью, Steam Workshop. Обязательно используй, когда пользователь просит собрать релиз или сборку для публикации, выложить на GitHub или в Workshop, обновить описание мода или README, сделать превью, поднять версию - даже если слово «релиз» не прозвучало.
---

# Релиз мода

Полный порядок в `docs/RELEASING.md`. Коротко:

1. `tools\validate.py` даёт 0 ошибок; пользователь прошёл `docs/TESTING.md` в новой партии, логи чистые.
2. Версия: файл `VERSION` (семвер, например `1.0.0-alpha`; идёт в имя архива и тег) и целое `version` у `<Mod>` в `.modinfo` (игра принимает только число); запись в `CHANGELOG.md`.
3. `tools\package.py` собирает `dist/release/RemselysAlexanderII-v<версия>.zip` и `.sha256` (внутри папка `RemselysAlexanderII`, в архив идёт только то, что в `<Files>`).
4. `git tag v<версия>`, `git push origin main v<версия>`, `gh release create ... dist/release/*`. **Push, tag и публикация - внешние необратимые действия: только по прямому согласию пользователя.** `gh` может быть не установлен.

## Описание и оформление
- Имя в игре: `[COLOR_RED]Remsely's[ENDCOLOR] Alexander II` (цвет из Civ6_ColorAtlas.xml; цвета палитры игроков в тексте невидимы) (`<Name>` в `.modinfo`). Описание и тизер - ключи `LOC_REMSELY_*_MOD_DESCRIPTION/TEASER` в обоих языках, абзацы через `[NEWLINE]`, списки через `[ICON_BULLET]`.
- Страница Workshop: `workshop/description.bbcode` (`[h1] [h2] [list] [olist]`), `workshop/workshop.json` (`visibility` 2 = скрытый), превью `workshop/preview.png` из `tools\make_preview.py`.
- GUID мода (`id` в `.modinfo`) между версиями не меняй: по нему игра узнаёт мод.
- BLP лежат для Windows и macOS (Asset Editor собирает оба, берутся из `Platforms/` проекта ModBuddy). Работу на macOS не проверяли - не обещай её.
- BLP для macOS не пересобираются скриптом: они лежат в проекте ModBuddy (`Documents\My Games\...\Mods\<проект>\Platforms\MacOS\BLPs`) рядом с Windows-версиями; копируй оба набора.
- Числа в описании (города, реплики, бонусы) сверяй с данными (`CityNames`, число тегов), а не с дизайн-документом: в первом релизе мы написали «список из 11 городов», хотя в моде 11 новых названий, а список России ванильный.
- README, описание и CHANGELOG должны совпадать с реальной механикой (числа из `docs/remselys-alexander-ii.md` и текста способности).

## Почему так
Релиз - единственная точка, где ошибка становится публичной и необратимой (тег, опубликованный архив, страница Workshop). Поэтому всё локальное (сборка, описание, превью) делай свободно, а всё внешнее показывай пользователю и жди его согласия.
