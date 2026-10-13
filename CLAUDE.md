# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Состояние проекта

Репозиторий — мод «Remsely's Alexander II» (альтернативный лидер России для Civilization VI). Сейчас в нём только `README.md` и `ROADMAP.md`: ни кода, ни `.modinfo`, ни инструментов сборки/тестов/линтинга ещё нет. Всё описанное ниже в разделах «Планируемая структура» и «Правила» взято из `ROADMAP.md` (разделы 2 и 4) и пока не реализовано. Перед опорой на файл или команду проверь, что они уже существуют.

Источники истины:
- `ROADMAP.md` — план по фазам, инструменты, ручные и автоматизируемые шаги (на русском).
- `docs/remselys-alexander-ii.md` — дизайн-документ (упомянут в роадмапе, в репозитории пока отсутствует).

Один репозиторий = один мод. Корень репозитория = ModBuddy-проект.

## Архитектура мода (планируемая)

Мод лидера — это в основном база данных и тексты плюс 2D-арт:
- `.modinfo` (XML) описывает файлы и действия (UpdateDatabase, UpdateText, UpdateArt, UpdateIcons) и зависимость от Rise and Fall / Gathering Storm.
- `Data/` — геймплей в SQL/XML: `Types`, `Leaders`, `CivilizationLeaders`, `LeaderTraits`, `Traits`, `Modifiers`, `Requirements`, `Agendas`, `LoadingInfo`, `PlayerColors`, список городов.
- `Lua/` — логика, которую нельзя выразить модификаторами (вероятно, смежность ферм и повестка «Освободитель»).
- `Text/` — `en_US.xml` и `ru_RU.xml`, ключи `LOC_`.
- `ArtDefs/`, `XLPs/`, `Textures/`, `Art.dep` — арт-зависимости; `art/source/` и `art/prompts.md` — исходники и промпты.
- `tools/` — `validate.py`, `slice_icons.py`, `requirements.txt` (Python, Pillow, lxml, pytest).
- `reference/` — в `.gitignore`: выгрузки баз игры (`DebugGameplay.sqlite`, `DebugLocalization.sqlite`), ванильные XML, образцы модов.

Cooking текстур (TEX, BLP) возможен только через Asset Editor из ModBuddy (только Windows). Игру, ModBuddy и Asset Editor запустить из Claude Code нельзя: на этих шагах остановись, напиши, что сделать вручную и какой лог прислать (`Database.log`, `Modding.log`, `Lua.log` из `Documents/My Games/Sid Meier's Civilization VI/Logs/`).

## Окружение (Windows)

- Python-зависимости в `.venv`: `.venv\Scripts\python.exe -m pip install -r tools\requirements.txt`; запуск — `.venv\Scripts\python.exe tools\validate.py`. `sqlite3` CLI и `gh` не установлены — для SQLite использовать модуль `sqlite3` из Python.
- Игра: `C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization VI`; SDK (ModBuddy, Asset Editor, FireTuner) — рядом, в `... Civilization VI SDK`.
- `reference/` в `.gitignore` и состоит из junction-ссылок на установку игры: `vanilla/{Base,Expansion1,Expansion2}` (данные и тексты), `samples/DLC` (официальные DLC-лидеры как образцы), `samples/SDK-{Examples,Documentation}`. `reference/game-db/` ждёт `DebugGameplay.sqlite` и `DebugLocalization.sqlite` (появятся после запуска игры с `CopyDatabasesToDisk 1` в `AppOptions.txt`).
- Моды ставятся в `Documents\My Games\Sid Meier's Civilization VI\Mods`.

## Команды

- `.venv\Scripts\python.exe tools\validate.py` — проверка: файлы из `.modinfo`, SQL прогоняется по копиям `DebugGameplay.sqlite` / `DebugConfiguration.sqlite` (ловит несуществующие таблицы и колонки, нарушения внешних ключей), парность `en_US`/`ru_RU`, префикс `REMSELY`, шесть падежей у имён, существование `LOC_`-ссылок.
- `.venv\Scripts\python.exe tools\install.py` — validate + копирование файлов из `<Files>` в `Documents\My Games\...\Mods\RemselysAlexanderII` (`--remove` удаляет). После установки игру нужно перезапустить.
- Новый файл мода нужно внести в `<Files>` и в действие `.modinfo` вручную (`.modinfo` пишется руками).
- Русские термины: `docs/terms.md`. Эталон структуры лидера-мода: `reference/samples/JFD-Russia-Elisabeth` (workshop-мод). Опыт перевода и формат падежей: репозиторий `..\civ6-leaders-mods-ru-localization` (`docs/TRANSLATION_GUIDE.md`).
- Пути в junction `reference/vanilla/Base` идут без `Assets`: `Base/Gameplay/Data`, `Base/Text`, `Base/UI`.
- Данные дополнений и локализации по умолчанию в базах игры соответствуют последнему загруженному набору правил: чтобы в `reference/game-db` были Rise and Fall/Gathering Storm, перед копированием нужно загрузить сохранение с ними. Базы лежат в `%LOCALAPPDATA%\Firaxis Games\Sid Meier's Civilization VI\Cache`.

## Правила

- Названия таблиц, колонок, типов модификаторов, эффектов и требований брать только из `reference/game-db/DebugGameplay.sqlite` или `reference/vanilla/`, не придумывать. Перед реализацией механики найти ванильный аналог и сослаться на него.
- Русские игровые термины — только из `DebugLocalization.sqlite`.
- Префикс `REMSELY_`; ключи текста вида `LOC_..._REMSELY_...`.
- Любая правка текста — сразу в оба языка (`en_US` и `ru_RU`).
- После любой правки запускать `python tools/validate.py` (когда валидатор появится — это Фаза 1 роадмапа).
