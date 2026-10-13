# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Состояние проекта

Репозиторий — мод «Remsely's Alexander II» (альтернативный лидер России для Civilization VI). Реализовано: лидер, способность «Великие реформы», повестка «Освободитель», города и столица, 31 реплика дипломатии, арт (портреты, иконки, фоны). Идут проверка в игре, вычитка текстов, полировка (см. `ROADMAP.md`).

Источники истины:
- `ROADMAP.md` — план по фазам, инструменты, ручные и автоматизируемые шаги (на русском).
- `docs/remselys-alexander-ii.md` — дизайн-документ (механики, повестка, реплики, композиции фонов, чек-лист проверки).
- `docs/art-pipeline.md` — как собирается арт; `docs/terms.md` — русские термины.

Один репозиторий = один мод. Корень репозитория = ModBuddy-проект.

## Архитектура мода

Мод лидера — это база данных, тексты и 2D-арт:
- `RemselysAlexanderII.modinfo` (пишется руками) описывает файлы и действия: во FrontEnd `Data/Config.sql` (экран выбора лидера), во InGame `Data/GameDefines.sql` (всё остальное); `Data/Icons.sql` (иконка лидера), `Data/Colors.sql` (цвета), `Text/{en_US,ru_RU}.xml`, `UpdateArt` с `RemselysAlexanderII.dep`.
- `Lua/RemselysAlexanderII_Farms.lua` — смежность ферм (считает соседей, ставит свойства клетки, которые читают XML-модификаторы).
- `art/source/` — исходные картинки; `tools/slice_art.py` режет их в `art/build/` (не в git), `tools/make_art.py` генерирует `Textures/*.dds|.tex`, `XLPs/`, `ArtDefs/`, `.dep`, `Data/Icons.sql`. BLP (`Platforms/{Windows,MacOS}/BLPs/`, оба набора кладёт Asset Editor/ModBuddy) собираются только в Asset Editor вручную; после изменения картинок их нужно пересобрать.
- `tools/validate.py`, `tools/install.py` — проверка и установка. `art/prompts.md` — промпты для нейросетей.
- `reference/` — в `.gitignore`: ванильные файлы игры, образцы модов, копии баз.

Игру, ModBuddy и Asset Editor запустить из Claude Code нельзя: на этих шагах остановись, напиши, что сделать вручную и какой лог прислать (`Database.log`, `Modding.log`, `Lua.log` из `%LOCALAPPDATA%\Firaxis Games\Sid Meier's Civilization VI\Logs\`).

## Окружение (Windows)

- Python-зависимости в `.venv`: `.venv\Scripts\python.exe -m pip install -r tools\requirements.txt`; запуск — `.venv\Scripts\python.exe tools\validate.py`. `sqlite3` CLI и `gh` не установлены — для SQLite использовать модуль `sqlite3` из Python.
- Игра: `C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization VI`; SDK (ModBuddy, Asset Editor, FireTuner) — рядом, в `... Civilization VI SDK`.
- `reference/` в `.gitignore` и состоит из junction-ссылок на установку игры: `vanilla/{Base,Expansion1,Expansion2}` (данные и тексты), `samples/DLC` (официальные DLC-лидеры как образцы), `samples/SDK-{Examples,Documentation}`. `reference/game-db/` — копии `DebugGameplay.sqlite`, `DebugLocalization.sqlite`, `DebugConfiguration.sqlite` из `%LOCALAPPDATA%\Firaxis Games\Sid Meier's Civilization VI\Cache` (перезаписываются при каждой загрузке набора правил игрой; в них могут быть следы сторонних модов).
- Моды ставятся в `Documents\My Games\Sid Meier's Civilization VI\Mods`.

## Команды

- `.venv\Scripts\python.exe tools\validate.py` — проверка: файлы из `.modinfo`, SQL прогоняется по копиям `DebugGameplay.sqlite` / `DebugConfiguration.sqlite` (ловит несуществующие таблицы и колонки, нарушения внешних ключей), парность `en_US`/`ru_RU`, префикс `REMSELY`, шесть падежей у имён, существование `LOC_`-ссылок; цвета (`UpdateColors`) проверяются по ванильным XML из `reference/vanilla/Base/UI/Colors` (в игре у таблицы `PlayerColors` нет `TextColor`, зато есть `Alt1..3`). Lua не проверяется.
- `.venv\Scripts\python.exe tools\install.py` — validate + копирование файлов из `<Files>` в `Documents\My Games\...\Mods\RemselysAlexanderII` (`--remove` удаляет). После установки игру нужно перезапустить.
- `.venv\Scripts\python.exe tools\package.py` — validate + `dist/release/RemselysAlexanderII-v<версия>.zip` (+ `.sha256`) для GitHub Releases; `tools\make_preview.py` — `workshop/preview.png`. Порядок выпуска: `docs/RELEASING.md`, проверка в игре: `docs/TESTING.md`.
- Новый файл мода нужно внести в `<Files>` и в действие `.modinfo` вручную (`.modinfo` пишется руками).
- Русские термины: `docs/terms.md`. Эталон структуры лидера-мода: `reference/samples/JFD-Russia-Elisabeth` (workshop-мод). Опыт перевода и формат падежей: репозиторий `..\civ6-leaders-mods-ru-localization` (`docs/TRANSLATION_GUIDE.md`).
- Пути в junction `reference/vanilla/Base` идут без `Assets`: `Base/Gameplay/Data`, `Base/Text`, `Base/UI`.
- Данные дополнений и локализации по умолчанию в базах игры соответствуют последнему загруженному набору правил: чтобы в `reference/game-db` были Rise and Fall/Gathering Storm, перед копированием нужно загрузить сохранение с ними. Базы лежат в `%LOCALAPPDATA%\Firaxis Games\Sid Meier's Civilization VI\Cache`.

## Скиллы проекта (`.claude/skills/`)

- `civ6-leader-art` — арт и его грабли (BLP, размеры, имена текстур, Portrait/PortraitBackground).
- `civ6-mod-verify` — validate/install, логи игры, что валидатор не ловит.
- `civ6-leader-texts` — полный набор текстов лидера, падежи, цитаты.
- `civ6-leader-data` — SQL/Lua: города, цвета, способность, повестка.
- `civ6-mod-release` — релиз, описание, Workshop.

## Правила

- Названия таблиц, колонок, типов модификаторов, эффектов и требований брать только из `reference/game-db/DebugGameplay.sqlite` или `reference/vanilla/`, не придумывать. Перед реализацией механики найти ванильный аналог и сослаться на него.
- Русские игровые термины — только из `DebugLocalization.sqlite`.
- Префикс `REMSELY_`; ключи текста вида `LOC_..._REMSELY_...`.
- Любая правка текста — сразу в оба языка (`en_US` и `ru_RU`).
- После любой правки запускать `python tools/validate.py`.
- Новая картинка арта: `slice_art.py`, `make_art.py`, пересборка BLP в Asset Editor, `install.py`.
- Ошибки данных ищи в `Database.log` / `Modding.log` (например, `[ColorManager] ERROR`): валидатор ловит не всё.
