# Remsely's Alexander II

Мод для Civilization VI: Александр II как альтернативный лидер России.

Статус: геймплей (способность, повестка, города, реплики дипломатии) и арт (портрет, иконка, фон загрузки, fallback дипломатии) реализованы; идут проверка в игре, вычитка текстов и полировка. План работ: [ROADMAP.md](ROADMAP.md), дизайн: [docs/remselys-alexander-ii.md](docs/remselys-alexander-ii.md).

Требуется Rise and Fall (Gathering Storm рекомендуется).

## Разработка

Только Windows (SDK Civilization VI). Подробности и правила для Claude Code: [CLAUDE.md](CLAUDE.md).

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r tools\requirements.txt
.\.venv\Scripts\python.exe tools\validate.py   # проверка мода
.\.venv\Scripts\python.exe tools\install.py    # проверка и установка в папку модов игры
.\.venv\Scripts\python.exe tools\slice_art.py   # арт: нарезка портретов, фонов и иконок из art/source
.\.venv\Scripts\python.exe tools\make_art.py    # арт: DDS, .tex, .xlp, .artdef, .dep (BLP собирает Asset Editor, см. docs/art-pipeline.md)
```

Папка `reference/` (в `.gitignore`) состоит из ссылок на файлы игры и выгрузок баз данных, см. раздел «Окружение» в `CLAUDE.md`.
