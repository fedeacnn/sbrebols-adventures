# Asset Management System — Istruzioni per l'Agente

Questo file descrive il workflow completo per gestire la produzione grafica di un progetto tramite AI.
Il sistema è stato sviluppato su SlothLock e può essere adottato su qualsiasi progetto app/game.

---

## 0. Filosofia del Sistema

Ogni schermata, funzionalità o categoria visiva del progetto ha un **file `.md` dedicato** che contiene i prompt per la generazione AI di tutti gli asset correlati.
L'obiettivo è garantire **coerenza visiva totale** tra tutti gli asset, indipendentemente da quando e con quale generatore AI vengono prodotti.

**Principio chiave:** il prompt non descrive "un'immagine bella" — descrive un sistema riproducibile. Ogni parametro visivo (colori, proporzioni, luce, stile) deve essere dichiarato esplicitamente con valori fissi (hex, temperature kelvin, angoli).

---

## 1. Struttura Cartelle

```
docs/
  ASSETS_STYLE_GUIDE.md        ← Guida stile unificata del progetto (OBBLIGATORIA)
  README_ASSETS.md             ← Indice di tutti i file asset con conteggio
  assets/
    BRANDING.md                ← Logo, splash, icona app
    MASCOT.md                  ← Personaggio principale (se presente)
    ONBOARDING.md              ← Schermate onboarding
    FEATURE_[NOME].md          ← Un file per ogni funzionalità/schermata
    BADGES_[TIPO].md           ← Un file per ogni categoria di badge/reward
    STATS.md                   ← Icone statistiche
    EMPTY_STATES.md            ← Illustrazioni stati vuoti
    NOTIFICATIONS.md           ← Icone notifiche

assets/
  images/
    branding/
    mascot/
    onboarding/
    [feature_name]/
    badges/
    stats/
    empty/
    notifications/
```

---

## 2. Come Iniziare un Nuovo Progetto

### Passo 1 — Creare la Style Guide

Prima di qualsiasi altro file, creare `docs/ASSETS_STYLE_GUIDE.md` con:

1. **Stile illustrazione globale** — definire lo stile visivo (es. kawaii, flat design, pixel art, realistico) e le keyword obbligatorie presenti in ogni prompt
2. **Personaggio principale** (se esiste) — descriptor fisso da usare identico in ogni asset
3. **Palette colori** — tutti i colori con nome, hex e contesto d'uso
4. **Formati e dimensioni** — tabella per categoria (badge, icona, tutorial, ecc.)
5. **Ricette lighting** — 2-4 ricette luce con direzione, temperatura K e mood
6. **Vocabolario materiali** — descrittori canonici per pelliccia, metallo, vetro, ecc.
7. **Expression bank** — dizionario emozioni con i token da usare nei prompt
8. **Composition grammar** — regole di inquadratura per categoria
9. **Snippet riutilizzabili** — blocchi di testo nominati ([IDENTITY_BASE], [STYLE_STANDARD], [TECH_256], ecc.)
10. **Negative prompt condiviso** — blocco esclusioni da appendere a ogni prompt
11. **Checklist qualità** — lista di controllo prima di finalizzare un prompt

### Passo 2 — Creare README_ASSETS.md

Un indice di tutti i file `.md` asset con: percorso, sezione, numero di asset.

### Passo 3 — Creare i file asset

Un file per ogni categoria/funzionalità, seguendo il formato canonico descritto nella sezione 3.

---

## 3. Formato Canonico di un File Asset

Ogni file in `docs/assets/` ha questa struttura:

```markdown
# [Nome Categoria/Funzionalità]

[Breve descrizione: cosa rappresenta questa categoria, quanti asset contiene,
eventuali regole specifiche di questa sezione che si aggiungono alla style guide globale]

=====================================
FILE: assets/images/[categoria]/[nome_file].ext
SIZE: LARGHEZZAxALTEZZA
=====================================
PROMPT:
[prompt completo per il generatore AI]
=====================================
```

Ogni file può contenere **N blocchi** `=====================================` consecutivi, uno per asset.

---

## 4. Struttura Canonica del Prompt

Ogni prompt è composto da **8 blocchi semantici** in questo ordine fisso:

```
IDENTITY  → chi è il soggetto (usare il descriptor fisso dalla style guide)
ACTION    → cosa sta facendo, posa, espressione (token dall'expression bank)
SCENE     → contesto, props fisici, elementi di scena, atmosfera
LIGHTING  → ricetta luce dichiarata (nome ricetta + direzione + temperatura K)
PALETTE   → 3-4 hex espliciti con nome colore e destinazione
STYLE     → token stilistici globali (copiati dalla style guide)
NEGATIVE  → blocco esclusioni (copiato dalla style guide + aggiunte specifiche)
TECH      → dimensione, formato, sfondo, aspect ratio, qualità
```

### Regole per ogni blocco

**IDENTITY**
- Usare sempre il descriptor fisso del personaggio dalla style guide — non parafrasare, non ridurre
- Il blocco IDENTITY deve essere identico (o quasi) su tutti gli asset per garantire coerenza

**ACTION**
- Usare i token dell'expression bank invece di descrizioni vaghe
- Specificare la posa con riferimenti spaziali (es. "right paw raised, left paw on belly")

**SCENE**
- Elencare esplicitamente cosa NON è nella scena oltre a cosa c'è
- Se l'asset richiede sfondo trasparente: specificare che il personaggio sta "alone on fully transparent canvas"
- Props fisici tenuti dal personaggio vanno descritti con materiale + colore hex

**LIGHTING**
- Citare il nome della ricetta (es. "Golden Hour recipe")
- Aggiungere sempre: direzione key light, temperatura colore in K
- Per asset su trasparente: "applied only to the subject" (no bloom ambientale)

**PALETTE**
- Mai "reddish" o "warm blue" — sempre hex esplicito
- Minimo 1 colore primario del brand + 1 colore accento

**STYLE**
- Copiare il token stilistico standard dalla style guide
- Non variare tra asset (garantisce coerenza)

**NEGATIVE**
- Partire sempre dal blocco base condiviso della style guide
- Aggiungere esclusioni specifiche di quella categoria (es. per tutorial: no UI mockup reali)
- Essere espliciti: ripetere "no background fill, no scene, no floor" anche se sembrano ovvi

**TECH**
- Usare sempre lo snippet tecnico della style guide per quella categoria
- Specificare: formato file, dimensioni in px, aspect ratio, qualità ("ultra crisp")

---

## 5. Regole d'Oro per la Consistenza

1. **Nessuna variante al descriptor del personaggio** — l'IDENTITY block è invariabile. Un generatore AI con lo stesso prompt produce risultati più consistenti di uno con varianti creative
2. **Hex sempre espliciti** — mai nomi colore generici nei prompt. Il generatore deve vedere "#D2B48C" non "beige"
3. **Stile dichiarato uguale su tutti gli asset** — il token `[STYLE_STANDARD]` viene copiato identico, non riformulato
4. **Negative prompt sempre presente** — è il 30% della qualità finale. Senza negative, il generatore "inventa"
5. **Props fisici, non elementi fluttuanti** — se il personaggio deve mostrare un concetto, tenerlo in mano fisicamente. Evitare icone fluttuanti intorno al personaggio
6. **Sfondo trasparente = zero scene** — su asset trasparenti, niente suolo, niente cielo, niente gradiente. Solo soggetto e props fisici tenuti

---

## 6. Sistema di Snippet Nominati

Per evitare drift progressivo (ogni copia manuale introduce piccole variazioni), usare snippet nominati nel file style guide:

```markdown
### [IDENTITY_BASE]
[testo completo del descriptor del personaggio]

### [STYLE_STANDARD]
[token stilistici globali]

### [NEGATIVE_BASE]
[blocco esclusioni condiviso]

### [TECH_TRANSPARENT_256]
transparent background (PNG alpha), no text, no watermarks, 1:1 square, 256×256 px, ultra crisp

### [TECH_TRANSPARENT_512]
transparent background (PNG alpha), no text, no watermarks, 1:1 square, 512×512 px, ultra crisp
```

Quando si scrive un prompt nel file asset, espandere lo snippet inline (non usare la notazione `[SNIPPET_NAME]` — i generatori AI non la capiscono). La style guide è la fonte di verità; i file asset contengono il testo già espanso.

---

## 7. Categorie Asset Standard

Queste categorie coprono la maggior parte dei progetti app. Aggiungere/rimuovere in base al progetto.

| Categoria | File | Dimensione tipica | Sfondo |
|-----------|------|-------------------|--------|
| Logo / icona app | `BRANDING.md` | 1024×1024 | Solido |
| Splash | `BRANDING.md` | 512×512 | Trasparente |
| Personaggio principale (livelli) | `MASCOT.md` | 512×512 | Trasparente |
| Onboarding | `ONBOARDING.md` | 512×512 | Trasparente |
| Feature / schermata | `FEATURE_[NOME].md` | 256×256 (icon), 480×320 (tutorial) | Trasparente / Scuro |
| Badge / reward | `BADGES_[TIPO].md` | 256×256 | Trasparente |
| Statistiche | `STATS.md` | 256×256 | Trasparente |
| Stati vuoti | `EMPTY_STATES.md` | 240×240 | Trasparente |
| Notifiche | `NOTIFICATIONS.md` | 256×256 | Trasparente |

---

## 8. Checklist Qualità — Prima di Finalizzare un Prompt

- [ ] Inizia con `[IDENTITY_BASE]` espanso inline (se contiene il personaggio)
- [ ] Dichiara la ricetta lighting con nome + direzione + temperatura K
- [ ] Cita almeno 3 hex con nome — mai "reddish" o "bluish"
- [ ] Contiene almeno 1 colore primario del brand
- [ ] Espressione scelta dall'Expression Bank della style guide
- [ ] Composizione dichiarata secondo la Composition Grammar della style guide
- [ ] Materiali descritti con il vocabolario canonico (no "shiny" generico)
- [ ] Appende `[NEGATIVE_BASE]` + eventuali aggiunte specifiche della categoria
- [ ] Termina con il TECH snippet corretto per la categoria
- [ ] Nessuna ripetizione di parole tra blocchi (no "cute" 5 volte)
- [ ] Lunghezza totale prompt: 80–180 parole (sweet spot per tokenizer moderni)
- [ ] Props fisici, non elementi fluttuanti
- [ ] Se trasparente: "stands alone on fully transparent canvas" dichiarato esplicitamente nel SCENE block

---

## 9. Come Aggiungere un Nuovo Asset

1. Identificare il file `.md` di destinazione (o crearne uno nuovo se la categoria non esiste)
2. Aggiungere in cima al file una nota della nuova sezione se necessario
3. Scrivere il blocco seguendo il formato canonico (sezione 3)
4. Verificare la checklist qualità (sezione 8)
5. Aggiornare il conteggio totale in `README_ASSETS.md`

---

## 10. Esempio Minimale — Come Appare un Prompt Completo

```
=====================================
FILE: assets/images/onboarding/mascot/welcome.png
SIZE: 512x512
=====================================
PROMPT:
IDENTITY: [IDENTITY_BASE espanso inline]
ACTION: standing upright, one paw raised in a warm enthusiastic wave; bright
crescent-moon smile, eyes squished into happy upturned arcs, cheeks lifted.
SCENE: the only prop is a tiny [brand color] bandana physically tied at the
neck; no branch, no birds, no scene, character stands alone on fully transparent canvas.
LIGHTING: Golden Hour recipe applied only to the subject — soft warm key light
from upper-left at 45°, ~3200K warm amber, gentle rim light tracing the fur
silhouette, diffused ambient fill, no volumetric scene bloom.
PALETTE: [hex fur] fur, [hex mask] mask, soft rosy pink cheeks, [hex brand] bandana,
golden [hex] catchlight accent.
STYLE: [STYLE_STANDARD espanso inline]
NEGATIVE: [NEGATIVE_BASE espanso inline] + avoid: any background fill, any scene,
any floor, any birds, any sky, any gradient backdrop.
TECH: fully transparent PNG background (alpha = 0 everywhere outside the character
silhouette and its worn bandana), no watermark, no text, 1:1 square, 512×512 px,
3/4 view facing slightly right, centered in frame with 10% padding, ultra crisp.
=====================================
```

---

## 11. Workflow dell'Agente

Quando viene assegnato un task di produzione grafica, l'agente deve:

1. **Leggere** `docs/ASSETS_STYLE_GUIDE.md` (fonte di verità globale)
2. **Leggere** il file `.md` della categoria richiesta (contesto specifico)
3. **Scrivere** il prompt espandendo gli snippet inline
4. **Verificare** la checklist qualità (sezione 8)
5. **Aggiornare** `README_ASSETS.md` se viene aggiunto un nuovo asset
6. **Non modificare** la Style Guide senza istruzioni esplicite — è la fonte di verità immutabile

Se la Style Guide non esiste ancora per il nuovo progetto, il primo compito dell'agente è crearla intervistando il responsabile del progetto sugli 11 punti elencati nella sezione 2.

---

## Riferimento

Questo sistema è stato sviluppato e testato sul progetto **SlothLock** (128 asset, stile kawaii illustrativo).
La Style Guide e i file asset di SlothLock in `docs/` e `docs/assets/` sono un riferimento concreto di come appare il sistema a regime.
