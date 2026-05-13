# CLAUDE.md — Sbrebols e il Tesoro della Ciurma

Questo file è il briefing tecnico per Claude Code. Leggilo integralmente prima di toccare qualsiasi file del progetto.

---

## STACK TECNICO

- **Engine:** Godot 4.x (GDScript)
- **Piattaforme target:** iOS, Android
- **Versione minima Android:** API 24 (Android 7.0)
- **Versione minima iOS:** 14.0
- **Orientamento:** Portrait fisso
- **Risoluzione base:** 390x844 (iPhone 14 reference), scaling con Expand
- **Repository:** Git (locale + remoto GitHub)

---

## STRUTTURA CARTELLE

```
sbrebols/
├── CLAUDE.md
├── GDD_Sbrebols.md          # Game Design Document — fonte di verità per contenuti
├── project.godot
├── assets/
│   ├── fonts/
│   ├── images/
│   │   ├── ui/
│   │   ├── characters/
│   │   ├── islands/
│   │   └── items/
│   ├── audio/
│   │   ├── music/
│   │   └── sfx/
│   └── animations/
├── scenes/
│   ├── core/
│   │   ├── Main.tscn         # entry point, gestisce transizioni globali
│   │   ├── GameManager.tscn  # autoload, stato globale partita
│   │   └── AudioManager.tscn # autoload, gestione musica e sfx
│   ├── ui/
│   │   ├── MainMenu.tscn
│   │   ├── HUD.tscn
│   │   ├── DialogueBox.tscn  # sistema dialoghi riutilizzabile
│   │   └── TransitionScreen.tscn
│   ├── world/
│   │   ├── Overworld.tscn    # mappa dei 10 mari con isole sbloccabili
│   │   └── Ship.tscn         # barca di Sbrebols, scena di navigazione
│   ├── islands/
│   │   ├── island_01_calebres/
│   │   │   ├── Island01_Intro.tscn
│   │   │   ├── Island01_Stage1.tscn
│   │   │   ├── Island01_Stage2.tscn
│   │   │   ├── Island01_Boss.tscn
│   │   │   └── Island01_Redemption.tscn
│   │   └── ... (island_02 ... island_10)
│   └── minigames/
│       ├── InfiniteRunner.tscn
│       ├── RhythmParry.tscn
│       ├── BulletHell.tscn
│       └── ... (un file per ogni minigioco)
└── scripts/
    ├── core/
    │   ├── GameManager.gd
    │   ├── AudioManager.gd
    │   ├── SaveSystem.gd
    │   └── SceneTransition.gd
    ├── ui/
    │   ├── DialogueSystem.gd
    │   └── HUD.gd
    ├── player/
    │   └── Sbrebols.gd
    ├── islands/
    │   ├── IslandBase.gd     # classe base ereditata da ogni isola
    │   └── island_01/
    │       ├── CambusSenior.gd
    │       └── CambOne.gd
    └── minigames/
        ├── MinigameBase.gd   # classe base ereditata da ogni minigioco
        ├── InfiniteRunner.gd
        ├── RhythmParry.gd
        └── BulletHell.gd
```

---

## AUTOLOADS (SINGLETON)

Registra questi tre come Autoload in project.godot:

| Nome | Script | Scopo |
|------|--------|-------|
| `GameManager` | scripts/core/GameManager.gd | stato globale, isole completate, chiavi raccolte, ciurma |
| `AudioManager` | scripts/core/AudioManager.gd | play/stop musica e sfx da qualsiasi scena |
| `SceneTransition` | scripts/core/SceneTransition.gd | transizioni animate tra scene |

---

## ARCHITETTURA CHIAVE

### GameManager (stato globale)
```gdscript
# Tiene traccia di tutto tra una scena e l'altra
var keys_collected: Array = []       # max 10
var crew_members: Array = []         # chi si è unito
var current_island: int = 0          # 1-10
var islands_completed: Array = []
```

### MinigameBase (classe base)
Ogni minigioco eredita da questa classe. Espone due segnali standard:
```gdscript
class_name MinigameBase
extends Node2D

signal minigame_completed(success: bool)
signal minigame_score_updated(score: int)

func start_minigame() -> void:
    pass  # override in ogni minigioco

func end_minigame(success: bool) -> void:
    emit_signal("minigame_completed", success)
```

### IslandBase (classe base)
```gdscript
class_name IslandBase
extends Node2D

var island_id: int
var boss_defeated: bool = false

func start_island() -> void:
    pass

func complete_island() -> void:
    GameManager.islands_completed.append(island_id)
    GameManager.keys_collected.append(island_id)
```

### DialogueSystem
I dialoghi sono definiti in file JSON nella cartella `assets/dialogues/island_XX/`.
Il nodo `DialogueBox.tscn` li legge e li mostra. Struttura del JSON:
```json
{
  "dialogue_id": "island01_intro",
  "lines": [
    { "speaker": "Cambus Senior", "text": "..." },
    { "speaker": "Sbrebols", "text": "..." }
  ]
}
```

---

## CONVENZIONI DI CODICE

- **Lingua:** inglese per tutto il codice (variabili, funzioni, commenti)
- **Lingua:** italiano per tutti i testi di gioco (dialoghi, UI, nomi)
- **Naming:** snake_case per variabili e funzioni, PascalCase per classi e scene
- **Segnali:** sempre dichiarati in cima al file, prima delle variabili
- **Nessun magic number:** usa costanti nominate (`const MAX_LIVES = 3`)
- **Una responsabilità per script:** ogni .gd gestisce un solo concetto
- **Commenti:** scrivi il perché, non il cosa

---

## SISTEMA DI SALVATAGGIO

Usa `SaveSystem.gd` per tutto. Salva su `user://save.json`.
Mai accedere direttamente a `FileAccess` dall'esterno di SaveSystem.

```gdscript
# Uso corretto
SaveSystem.save_game()
SaveSystem.load_game()
```

---

## TOUCH INPUT

Su mobile ogni interazione avviene via touch. Regole:
- Mai assumere mouse input — usa sempre `InputEventScreenTouch` e `InputEventScreenDrag`
- Area minima tap: 48x48 dp (circa 144x144 px a 3x density)
- Per il gyroscopio: `Input.get_accelerometer()` — controlla sempre che sia disponibile

---

## FLUSSO DI UNA SCENA ISOLA

```
Island_XX_Intro.tscn
    → dialogo NPC introduttivo (DialogueSystem)
    → SceneTransition → Island_XX_Stage1.tscn (MinigameBase)
        → se completato → SceneTransition → Island_XX_Stage2.tscn
            → se completato → SceneTransition → Island_XX_Boss.tscn
                → se completato → Island_XX_Redemption.tscn (cutscene/dialogo)
                    → GameManager.complete_island()
                    → SceneTransition → Overworld.tscn
```

---

## ISOLA 1 — CALEBRES (prima da implementare)

Dettaglio completo nel GDD. Riassunto operativo:

| Scena | Minigioco | Stato |
|-------|-----------|-------|
| Island01_Intro | Dialogo Cambus Senior | da fare |
| Island01_Stage1 | Infinite Runner (piantagione banane) | da fare |
| Island01_Stage2 | Rhythm Parry (palestra) | da fare |
| Island01_Boss | Bullet Hell (Camb-ONE lancia banane) | da fare |
| Island01_Redemption | Cutscene dialogo | da fare |

**Inizia da qui:** scaffolding del progetto → GameManager → SceneTransition → Island01_Intro con DialogueSystem funzionante.

---

## COMANDI GIT STANDARD

```bash
# Setup iniziale (eseguire una volta)
git init
git remote add origin https://github.com/USERNAME/sbrebols.git

# Workflow quotidiano
git add .
git commit -m "feat: descrizione breve in inglese"
git push origin main

# Branch per feature
git checkout -b feature/island01-runner
git checkout main && git merge feature/island01-runner
```

Prefissi commit: `feat:` nuova funzionalità, `fix:` bug, `refactor:` pulizia codice, `assets:` aggiunta asset, `docs:` documentazione.

---

## PRIORITÀ DI SVILUPPO

1. Scaffolding progetto Godot + struttura cartelle
2. GameManager, AudioManager, SceneTransition (autoloads)
3. SaveSystem base
4. DialogueSystem + DialogueBox UI
5. Island01_Intro (primo dialogo giocabile)
6. InfiniteRunner (Tappa 1 Calebres)
7. RhythmParry (Tappa 2 Calebres)
8. BulletHell (Boss Camb-ONE)
9. Island01_Redemption + flusso completo isola 1
10. Overworld base con isola 1 sbloccata

Non procedere al punto N+1 prima che N sia testato su device fisico.

---

*Aggiorna questo file ogni volta che cambia l'architettura o vengono aggiunte nuove isole/minigiochi.*
