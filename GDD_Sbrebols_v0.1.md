# GAME DESIGN DOCUMENT — SBREBOLS E IL TESORO DELLA CIURMA
*Versione 0.1 — documento in costruzione*

---

## PANORAMICA GENERALE

**Titolo:** Sbrebols e il Tesoro della Ciurma
**Piattaforme:** iOS, Android
**Engine:** Godot 4
**Genere:** Avventura con minigiochi 2D
**Tono:** Avventuroso, umoristico, con momenti emotivi

---

## STORIA

### Contesto
La Velos Coguaros era la nave più veloce e temuta dei 10 mari, comandata dalla ciurma più rispettata di tutti i tempi. Un giorno, i membri della ciurma litigarono violentemente tra loro e smisero di parlarsi. Ognuno si rifugiò sulla propria isola, diventando col tempo cattivo e spietato.

### Inizio
Sbrebols, un giovane pirata, trova il relitto della Velos Coguaros. Esplorando la nave scopre:
- Un forziere con 10 toppe per altrettante chiavi
- Una mappa del tesoro che indica "Il Tesoro della Ciurma"

Incuriosito e affascinato, Sbrebols parte sulla sua barca a vela alla ricerca delle 10 chiavi, disperse nelle 10 isole dove si sono rifugiati gli ex membri della ciurma.

### Arco narrativo
In ogni isola Sbrebols affronta un ex membro della ciurma. Dopo averlo sconfitto, il personaggio si redime e si unisce alla sua avventura. Al termine delle 10 isole, la leggendaria ciurma della Velos Coguaros sarà ricostituita e il tesoro finalmente aperto.

### Protagonista
**Sbrebols** — giovane pirata curioso e intrepido. Carattere determinato ma amichevole, capace di far cambiare idea anche ai più ostinati.

---

## STRUTTURA DEL GIOCO

Ogni isola segue questo schema fisso:

1. **Sbarco e incontro con NPC introduttivo** — dialogo che contestualizza l'isola e il boss
2. **Tappa 1** — minigioco tematico
3. **Tappa 2** — minigioco tematico
4. **Boss Fight** — scontro finale con il guardiano della chiave
5. **Redenzione** — cutscene/dialogo, il boss si unisce alla ciurma
6. **Partenza** — Sbrebols salpa verso la prossima isola

---

## ISOLE

---

### ISOLA 1 — CALEBRES

**Boss:** Camb-ONE
**Tema:** Forza bruta, banane, allenamento
**Chiave:** A forma di banana

#### NPC Introduttivo: Cambus Senior
Appena sbarcato sull'isola, Sbrebols incontra Cambus Senior. Il vecchio spiega chi è Camb-ONE: un ex membro della ciurma noto per il suo petto enorme, ora dedito esclusivamente a mangiare banane e fare panca piana per mantenere il titolo di "petto più grosso dei 10 mari". Cambus Senior descrive la chiave a forma di banana e indica il percorso per raggiungerlo.

---

#### Tappa 1 — La Piantagione
**Minigioco:** Infinite Runner / Frogger style

Sbrebols deve attraversare le file della piantagione di Camb-ONE. I gorillini al servizio del boss lanciano bucce di banana sul percorso. Il giocatore deve avanzare evitando le scivolate su tre corsie, aumentando di velocità man mano che procede.

---

#### Tappa 2 — La Palestra del Re
**Minigioco:** Rhythm / Parry

Gli scagnozzi di Camb-ONE bloccano il passaggio e sfidano Sbrebols a una gara di forza. Il giocatore deve premere al momento giusto seguendo il ritmo per eseguire ripetizioni di sollevamento pesi con carichi sempre più pesanti. Superare la sfida convince i gorillini a farsi da parte.

---

#### Boss Fight — Camb-ONE
**Minigioco:** Bullet Hell a tema banane

Camb-ONE lancia banane a raffica contro Sbrebols. Il giocatore può:
- **Schivare** le banane spostandosi
- **Rilanciarle** indietro se passa vicino al momento giusto (timing preciso)

Più banane consecutive vengono rilanciate, maggiore è il danno inflitto. Quando la barra vita si svuota, Camb-ONE inciampa su una sua stessa buccia e cade rovinosamente.

---

#### Redenzione
Sbrebols si avvicina a Camb-ONE ancora a terra. Dialogo breve: il boss confuso ripensa a chi era prima della lite, a quanto mancavano i compagni. Sbrebols gli tende la mano. Camb-ONE consegna la chiave a forma di banana e si unisce alla ciurma.

---

*[Isola 2 — in definizione]*
*[Isola 3 — in definizione]*
*[Isola 4 — in definizione]*
*[Isola 5 — in definizione]*
*[Isola 6 — in definizione]*
*[Isola 7 — in definizione]*
*[Isola 8 — in definizione]*
*[Isola 9 — in definizione]*
*[Isola 10 — in definizione]*

---

## MINIGIOCHI DISPONIBILI (CATALOGO)

### Corsa e Riflessi
- Geometry Dash Style — salto ritmico su ostacoli fissi
- Infinite Runner — corsa infinita con tre corsie
- Dino Run — corsa 2D con velocità crescente
- Gravity Switcher — inversione della gravità invece del salto
- Flappy Mode — pressioni ripetute per mantenersi in volo
- Speedrun Chase — qualcosa ti insegue, non puoi fermarti

### Logica e Fisica
- Slippery Ice — movimento con inerzia
- Sokoban — spingi casse su interruttori
- Portal Maze — portali entrata/uscita
- Color Match — tocca solo le piattaforme del tuo colore
- Shadow Clone — non scontrarti con la tua ombra ritardata di 3 secondi

### Mira e Combattimento
- Bullet Hell — schivata pura di proiettili
- Target Shooter — colpisci bersagli in movimento
- Parry Master — defletti i colpi a ritmo di musica
- Arena Survival — resisti 30 secondi contro nemici casuali
- Boss Rush — battaglia multifase con barra vita gigante

### Movimento Speciale
- Grappling Hook — rampino per oscillare tra perni
- Vertical Climber — salto continuo verso l'alto
- Jetpack — gestione carburante per volare con precisione
- Diving/Swimming — movimento 360° in fluido
- Swing & Release — ruota e lanciati al momento giusto

### Arcade Classici
- Snake Mode — raccogli oggetti che allungano la coda
- Frogger Style — attraversa strade/fiumi con ostacoli laterali
- Stealth — muoviti solo quando i nemici non guardano

### Mobile Native
- Tilt/Gyroscope — inclina il telefono per guidare il personaggio
- Swipe Combo — sequenze di swipe direzionali a ritmo crescente
- Draw Path — traccia un percorso con il dito, il personaggio lo segue
- Pinpoint Tap — tocca bersagli precisi che appaiono e spariscono rapidamente

### Pirata e Navigazione
- Cannon Aim — regola angolo e potenza del cannone con uno slider
- Treasure Dig — griglia nascosta, scavi limitati (stile Minesweeper)
- Ship Balance — bilancia il carico della nave inclinando il telefono
- Knot Puzzle — collega corde/nodi nel giusto ordine prima che il tempo scada

### Distorsione (Alta Difficoltà)
- Upside Down — schermo o comandi capovolti
- Lights Out — visibilità solo in un piccolo cerchio
- Invisible Path — piattaforme visibili solo ogni 2 secondi

---

*Fine documento v0.1*
