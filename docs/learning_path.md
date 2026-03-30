# FinFlow — Percorso di Apprendimento Flutter

Programma step-by-step per imparare Flutter costruendo FinFlow Phase 1.
Ogni step insegna 1-2 concetti nuovi e produce un pezzo funzionante dell'app.

> **Come usare questo documento:** segui gli step in ordine. Per ogni step, leggi la sezione teoria, poi implementa. Usa `/project:tutor` per chiedere spiegazioni, revisioni del codice, o aiuto quando sei bloccato.

---

## TIER A — Fondamenta

### Step 1: Project Scaffold & Widget Tree

**Cosa imparerai:**
- Come Flutter costruisce la UI: tutto e un **Widget** (albero di widget annidati)
- `StatelessWidget`: widget che non cambiano stato, definiti da un metodo `build()`
- `BuildContext`: l'oggetto che ogni widget riceve e che rappresenta la sua posizione nell'albero (come `context.Context` in Go — porta informazioni dall'alto verso il basso)
- Costruttori `const`: ottimizzazione Flutter per widget che non cambiano mai
- `MaterialApp` e `Scaffold`: i widget strutturali base di ogni app Material

**Analogie Go/Python:**
- I widget sono come funzioni pure che restituiscono UI: ricevono parametri (props) e restituiscono un albero di elementi. Pensa a template Go annidati, ma type-safe.
- `BuildContext` e come `context.Context` in Go: non contiene dati tuoi, ma ti permette di accedere a servizi registrati piu in alto nell'albero (tema, navigazione, localizzazione).
- `const` in Dart e simile a costanti compile-time in Go — Flutter riusa l'istanza identica invece di ricrearla.

**Cosa costruirai:**
- Struttura cartelle del progetto: `lib/core/`, `lib/features/`, `lib/app.dart`
- `app.dart` con `MaterialApp` e una schermata home placeholder
- `main.dart` pulito che lancia l'app

**File da creare:**
```
lib/
├── main.dart                  # Entry point: runApp(const FinFlowApp())
├── app.dart                   # MaterialApp con home placeholder
├── core/
│   ├── theme/                 # (vuoto, preparato per Step 2)
│   ├── widgets/               # (vuoto, preparato per Step 3)
│   ├── database/              # (vuoto, preparato per Step 6)
│   ├── router/                # (vuoto, preparato per Step 4)
│   ├── constants/
│   └── utils/
└── features/
    ├── dashboard/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── transactions/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── recurring/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── accounts/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── categories/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── calendar/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── settings/
    │   └── presentation/
    └── onboarding/
        └── presentation/
```

**Concetti chiave da capire prima di procedere:**
- Perche `build()` puo essere chiamato molte volte (Flutter ricostruisce i widget quando i dati cambiano)
- La differenza tra widget (descrizione) ed element (istanza renderizzata)
- Perche `const` e importante per le performance

**Docs Flutter:** https://docs.flutter.dev/ui/widgets-intro

---

### Step 2: Design System — Theme, Colors, Typography

**Cosa imparerai:**
- `ThemeData`: l'oggetto che contiene tutti i valori di stile dell'app
- `ThemeExtension<T>`: come aggiungere token custom al tema (i nostri colori FinFlow)
- Extension methods su `BuildContext`: scorciatoie tipo `context.ffColors` per accedere ai token
- `Color`, `TextStyle`, `BoxShadow`, `BorderRadius`: le primitive di stile Flutter
- `google_fonts`: come caricare font personalizzati

**Analogie Go/Python:**
- `ThemeExtension` e come dependency injection: registri valori al livello `MaterialApp` e li recuperi ovunque nell'albero via `Theme.of(context)`. Simile a `flask.g` in Python o a valori nel `context.Context` Go.
- L'extension method `context.ffColors` e come un metodo su un'interfaccia Go — aggiunge comportamento a un tipo esistente senza modificarlo.

**Cosa costruirai:**
I 6 file del design system + una schermata di preview che mostra tutti i token:

| File | Contenuto |
|------|-----------|
| `finflow_colors.dart` | `ThemeExtension<FinFlowColors>` con tutti i colori semantici |
| `finflow_typography.dart` | Costanti `TextStyle` per display, heading, body, caption |
| `finflow_spacing.dart` | Costanti `double` per spacing (4px base unit) |
| `finflow_radius.dart` | Costanti `BorderRadius` |
| `finflow_shadows.dart` | Costanti `BoxShadow` |
| `finflow_theme.dart` | Funzione che assembla `ThemeData` con tutte le extension |

**Regola fondamentale:** da questo momento, MAI usare `Color(0xFF...)` direttamente nei widget. Sempre `context.ffColors.nomeProprieta`.

**Riferimento token:** usa `/project:finflow-theme` per i valori esatti.

**Docs Flutter:** https://docs.flutter.dev/cookbook/design/themes

---

### Step 3: Widget Riutilizzabili — FFButton, FFCard, FFInput, FFListItem

**Cosa imparerai:**
- **Composizione vs ereditarieta**: Flutter preferisce comporre widget piccoli piuttosto che ereditare da widget grandi
- **Callback**: come passare funzioni ai widget figli (`VoidCallback`, `ValueChanged<T>`)
- `StatefulWidget`: widget che mantengono stato interno (es. focus di un input, animazione toggle)
- `InkWell` / `GestureDetector`: come rendere tappabile qualsiasi widget
- **Ciclo di vita widget**: `initState()`, `dispose()`, `didUpdateWidget()`

**Analogie Go/Python:**
- I callback sono come le function type in Go (`func()` = `VoidCallback`, `func(string)` = `ValueChanged<String>`). Il genitore definisce *cosa fare*, il figlio definisce *quando farlo*.
- `StatefulWidget` ha due classi: il widget (immutabile, come una struct Go) e lo state (mutabile, come i campi di un oggetto Python). Lo state sopravvive alle ricostruzioni del widget.
- Composizione in Flutter e come embedding in Go: invece di ereditare, includi widget dentro altri widget.

**Cosa costruirai:**
4 widget condivisi + una schermata Widget Gallery per testarli:

| Widget | Varianti | Interazione |
|--------|----------|-------------|
| `FFButton` | primary, secondary, pill toggle | `onPressed` callback |
| `FFCard` | standard, hero (gradient), stat box | Container passivo |
| `FFInput` | standard, amount (grande, centrato) | `onChanged`, `TextEditingController` |
| `FFListItem` | transazione/pagamento | `onTap` callback |

**Riferimento specifiche:** usa `/project:finflow-components` per dimensioni, padding, colori esatti.

**Docs Flutter:** https://docs.flutter.dev/ui/widgets/layout

---

### Step 4: Navigazione con GoRouter

**Cosa imparerai:**
- **Routing dichiarativo**: definisci le route come dati, non come chiamate imperative
- `GoRouter`: configurazione route, parametri path, redirect
- `ShellRoute`: route che wrappano le figlie con UI persistente (la bottom nav)
- Navigazione programmatica: `context.go()`, `context.push()`

**Analogie Go/Python:**
- La configurazione GoRouter e come definire route in Gin/Echo: dichiari path e handler (schermate). `ShellRoute` e come un middleware che wrappa i route figli con UI comune.
- `context.go('/transactions')` e come un redirect HTTP — sostituisce la route corrente. `context.push('/transaction/123')` e come aprire una nuova pagina — aggiunge allo stack.

**Cosa costruirai:**
- `FFBottomNav`: barra di navigazione inferiore con 4 tab
- `lib/core/router/app_router.dart`: configurazione GoRouter
- 4 schermate placeholder (Dashboard, Transazioni, Calendario, Impostazioni)
- Navigazione funzionante tra i tab

**Struttura route:**
```
/                     → Dashboard (tab 0)
/transactions         → Lista transazioni (tab 1)
/transactions/add     → Aggiungi transazione (push, no tab)
/calendar             → Calendario (tab 2)
/settings             → Impostazioni (tab 3)
```

**Docs Flutter:** https://pub.dev/packages/go_router

---

## TIER B — Data Layer

### Step 5: Modelli Dati con Freezed

**Cosa imparerai:**
- **Code generation** in Dart: `build_runner` genera codice da annotazioni (come `go generate`)
- `@freezed`: crea classi immutabili con `copyWith`, `==`, `hashCode`, `toString` automatici
- `@JsonSerializable`: serializzazione JSON automatica
- **Enum** in Dart: piu potenti che in Go (possono avere metodi e proprietà)
- **Union types**: come modellare stati diversi con `@freezed`

**Analogie Go/Python:**
- Freezed e come scrivere una struct Go con JSON tags, ma ti genera anche `copyWith` (crea una copia con campi modificati — in Go faresti `newStruct := oldStruct; newStruct.Field = newValue`).
- `build_runner` e esattamente `go generate`: legge annotazioni nel codice e genera file `.g.dart` / `.freezed.dart`.
- Gli enum Dart con metodi sono come gli enum Python (`class Color(Enum)`) — piu ricchi degli `iota` Go.

**Cosa costruirai:**
Entita del dominio FinFlow:

```dart
// Enum
enum TransactionType { income, expense }
enum RecurrenceFrequency { weekly, biweekly, monthly, bimonthly, quarterly, semiannual, annual, custom }

// Entita
@freezed class Category       // id, name, icon, color, isDefault
@freezed class Account        // id, name, type, balance, currency, icon
@freezed class Transaction    // id, amount, type, categoryId, accountId, date, notes
@freezed class RecurringPayment // id, name, amount, type, categoryId, accountId, frequency, startDate, endDate, customDays
```

**Comando da eseguire dopo:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Docs:** https://pub.dev/packages/freezed

---

### Step 6: Database Cifrato con Drift

**Cosa imparerai:**
- **Drift**: ORM/query builder per SQLite, type-safe, con codice generato
- **Tabelle**: definite come classi Dart, colonne come getter
- **DAO** (Data Access Object): classi che raggruppano query per feature
- **Type converter**: come mappare enum e tipi custom nelle colonne DB
- **Watch query**: stream che emettono nuovi risultati quando i dati cambiano
- **SQLCipher**: crittografia trasparente del database

**Analogie Go/Python:**
- Le tabelle Drift sono come definire schema SQL con sqlc (Go) o SQLAlchemy models (Python), ma completamente type-safe.
- I DAO sono come le struct repository in Go: raggruppano le query relative a un'entita.
- `watch()` e come un canale Go che emette ogni volta che la tabella cambia — non devi fare polling, il DB ti notifica.
- Le migrazioni Drift funzionano come `goose` o `alembic`: definisci `schemaVersion` e scrivi la migrazione nel metodo `migration`.

**Cosa costruirai:**
```
lib/core/database/
├── app_database.dart          # Classe database principale
├── tables/
│   ├── accounts_table.dart
│   ├── transactions_table.dart
│   ├── categories_table.dart
│   └── recurring_payments_table.dart
├── daos/
│   ├── accounts_dao.dart
│   ├── transactions_dao.dart
│   ├── categories_dao.dart
│   └── recurring_payments_dao.dart
└── type_converters.dart       # Enum ↔ int converters
```

Seed delle categorie default (Casa, Trasporti, Cibo, Svago, Salute, Stipendio, ecc.).

**Nota tecnica:** il `pubspec.yaml` ha `sqlite3_flutter_libs` — per la crittografia SQLCipher potresti dover usare `sqlcipher_flutter_libs`. Lo gestiamo insieme in questo step.

**Docs:** https://drift.simonbinder.eu/docs/getting-started/

---

### Step 7: State Management con Riverpod

**Cosa imparerai:**
- `ProviderScope`: il contenitore che racchiude l'intera app e gestisce i provider
- `@riverpod`: annotazione per generare provider automaticamente
- `ref.watch()` vs `ref.read()`: reattivo (ricostruisce il widget) vs one-shot (azione singola)
- `AsyncValue<T>`: il tipo che rappresenta loading/data/error (come `(T, error)` in Go ma con loading)
- `ConsumerWidget` / `ConsumerStatefulWidget`: widget che possono accedere ai provider

**Analogie Go/Python:**
- Riverpod e come un container di dependency injection reattivo. I provider sono singleton lazy che si auto-aggiornano.
- `ref.watch()` e come sottoscriversi a un canale Go: quando il valore cambia, il tuo widget si ricostruisce automaticamente.
- `ref.read()` e come una chiamata sincrona: leggi il valore una volta (es. dentro un `onPressed`).
- `AsyncValue` e come il pattern `(T, error)` di Go, ma con tre stati: `loading`, `data(T)`, `error(e)`. Lo usi con pattern matching: `when(data: ..., loading: ..., error: ...)`.
- Il grafo di provider e come il DAG di dipendenze in un container Python (FastAPI `Depends()`).

**Cosa costruirai:**
- Provider per il database: `appDatabaseProvider`
- Provider per ogni DAO: `categoriesDaoProvider`, `accountsDaoProvider`, ecc.
- Un provider che osserva le categorie dal DB: `categoriesProvider`
- Una schermata di test che mostra la lista categorie dal DB in tempo reale
- Pipeline completa funzionante: **Drift DB → Riverpod Provider → ConsumerWidget → UI**

**Questo e il momento "aha!":** vedrai i dati fluire dal database alla UI reattivamente, senza callback manuali.

**Comando da eseguire dopo:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Docs:** https://riverpod.dev/docs/introduction/getting_started

---

## TIER C — Feature Implementation

> Da qui in poi, ogni step segue lo stesso pattern architetturale:
> `features/<nome>/{data, domain, presentation}`
> Usa i concetti appresi nel Tier A e B per costruire feature complete.

### Step 8: Categorie (warm-up feature)

**Cosa imparerai:**
- Il pattern **vertical slice** completo: dal database alla UI passando per provider
- Come strutturare una feature nella cartella `features/`
- Grid layout con `Wrap` o `GridView` per i chip categoria
- Il widget `FFCategoryChip` con stato selezionato

**Cosa costruirai:**
```
features/categories/
├── data/
│   └── categories_repository.dart    # Usa il DAO, espone metodi business
├── domain/
│   └── category.dart                 # Re-export del modello Freezed
└── presentation/
    ├── providers/
    │   └── categories_providers.dart # Provider per lista e CRUD
    ├── screens/
    │   └── categories_screen.dart    # Schermata gestione categorie
    └── widgets/
        └── category_grid.dart        # Griglia di FFCategoryChip
```

Funzionalita: vedere tutte le categorie, aggiungerne di custom, selezionare (per uso futuro nelle transazioni).

**Backlog:** F1-05

---

### Step 9: Account

**Cosa imparerai:**
- Pattern CRUD completo (Create, Read, Update, Delete)
- `showModalBottomSheet`: bottom sheet per form di aggiunta/modifica
- `DropdownButton` / selettore per tipo account
- Seeding di dati iniziali (account di default)

**Cosa costruirai:**
```
features/accounts/
├── data/
│   └── accounts_repository.dart
├── domain/
│   └── account.dart
└── presentation/
    ├── providers/
    │   └── accounts_providers.dart
    ├── screens/
    │   └── accounts_screen.dart
    └── widgets/
        ├── account_list_tile.dart
        └── account_form_sheet.dart    # Bottom sheet add/edit
```

Account di default: Conto corrente, Carta di credito, Contanti.

**Backlog:** F1-07

---

### Step 10: Transazioni — Aggiungi & Lista

**Cosa imparerai:**
- **Form complesse**: combinare piu input, validazione, stato del form
- `TextEditingController`: controllare il valore di un campo testo programmaticamente
- Formattazione numeri **it_IT**: `3.247,52` con il package `intl`
- `DatePicker`: selettore data nativo Flutter
- `ListView.builder`: lista performante con rendering lazy (crea solo gli elementi visibili)
- Raggruppamento per data: come organizzare transazioni per giorno
- `FloatingActionButton` (FAB): il bottone flottante per aggiungere

**Cosa costruirai:**
```
features/transactions/
├── data/
│   └── transactions_repository.dart
├── domain/
│   └── transaction.dart
└── presentation/
    ├── providers/
    │   └── transactions_providers.dart
    ├── screens/
    │   ├── transactions_screen.dart   # Lista raggruppata per data
    │   └── add_transaction_screen.dart # Form aggiunta
    └── widgets/
        ├── transaction_group_header.dart  # Header data (es. "Oggi", "02 Apr")
        ├── amount_input.dart              # Input importo stile FinFlow
        └── transaction_filters.dart       # Search + filtri
```

**Backlog:** F1-01, F1-08

---

### Step 11: Pagamenti Ricorrenti

**Cosa imparerai:**
- **Logica di dominio complessa**: il motore che calcola le prossime occorrenze
- Date math in Dart: `DateTime`, `Duration`, package `intl` per formattazione
- Come separare logica pura (engine) dalla UI
- Pattern Strategy: frequenze diverse, stesso comportamento

**Cosa costruirai:**
```
features/recurring/
├── data/
│   └── recurring_repository.dart
├── domain/
│   ├── recurring_payment.dart
│   └── recurring_engine.dart          # Calcola prossime N occorrenze
└── presentation/
    ├── providers/
    │   └── recurring_providers.dart
    ├── screens/
    │   ├── recurring_screen.dart      # Lista pagamenti ricorrenti
    │   └── add_recurring_screen.dart  # Form creazione
    └── widgets/
        ├── frequency_selector.dart
        └── next_payments_preview.dart  # Preview prossime date
```

Il **recurring engine** e logica pura Dart (nessuna dipendenza Flutter) — perfetto per unit test.

**Backlog:** F1-02, F1-T02

---

### Step 12: Vista Calendario

**Cosa imparerai:**
- **Widget custom complessi**: costruire una griglia calendario da zero
- `GestureDetector` su celle individuali
- Combinare dati da piu provider (transazioni + ricorrenti per un dato giorno)
- `FFCalendarDayCell` con indicatori di pagamento
- Navigazione tra mesi

**Cosa costruirai:**
```
features/calendar/
├── data/
│   └── calendar_repository.dart       # Aggrega dati per il calendario
├── domain/
│   └── calendar_day.dart              # Modello: data + lista pagamenti
└── presentation/
    ├── providers/
    │   └── calendar_providers.dart
    ├── screens/
    │   └── calendar_screen.dart
    └── widgets/
        ├── month_calendar_grid.dart   # Griglia 7 colonne
        ├── day_detail_panel.dart      # Dettaglio giorno selezionato
        └── month_selector.dart        # Navigazione mese
```

**Backlog:** F1-03, F1-T04

---

## TIER D — Integrazione & Polish

### Step 13: Dashboard & Onboarding

**Cosa imparerai:**
- **Provider computati**: provider che combinano dati da piu sorgenti (saldo, totali mese)
- `fl_chart`: grafici interattivi per stat box
- `PageView`: schermate swipeable per onboarding
- Come comporre widget di feature diverse in una singola schermata

**Cosa costruirai:**

**Dashboard** (`features/dashboard/presentation/`):
- Hero card con saldo attuale (Instrument Serif grande)
- Riga di 3 stat box (spese mese, entrate mese, risparmio)
- Mini forecast bar
- Lista prossimi pagamenti (dai ricorrenti)
- Lista transazioni recenti

**Onboarding** (`features/onboarding/presentation/`):
- Welcome screen
- Aggiungi account iniziali
- Aggiungi primi pagamenti ricorrenti
- Schermata completamento

**Backlog:** F1-04, F1-09

---

### Step 14: Polish, Stati & CSV Import

**Cosa imparerai:**
- **Empty state**: schermate vuote con illustrazione + CTA (mai solo testo)
- **Loading skeleton**: shimmer effect al posto di spinner (il pattern FinFlow)
- **Animazioni implicite**: `AnimatedContainer`, `AnimatedOpacity` — dichiari lo stato finale, Flutter anima la transizione
- **Error handling**: come gestire errori con `AsyncValue` e mostrare feedback
- **File picker**: selezionare file dal dispositivo
- **CSV parsing**: leggere e interpretare file CSV

**Cosa costruirai:**
- Widget `FFEmptyState` riutilizzabile
- Widget `FFShimmerCard` per loading skeleton
- Feedback con snackbar per azioni (salvato, eliminato, errore)
- Dialog di conferma per azioni distruttive
- `features/transactions/data/csv_parser.dart` per import CSV banche italiane
- Preparazione struttura tema Obsidian (dark) — solo token, non ancora attivo

**Backlog:** F1-06, F1-T03, F1-T05

---

## Riepilogo Pacchetti per Step

| Step | Pacchetti nuovi |
|------|----------------|
| 1 | — (solo Flutter SDK) |
| 2 | `google_fonts` |
| 3 | `lucide_icons` |
| 4 | `go_router` |
| 5 | `freezed_annotation`, `freezed`, `json_serializable`, `json_annotation`, `build_runner` |
| 6 | `drift`, `sqlite3_flutter_libs` / `sqlcipher_flutter_libs`, `path_provider`, `path` |
| 7 | `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`, `riverpod_lint` |
| 8-14 | `intl`, `fl_chart`, `csv`, `uuid` (gia in pubspec.yaml, li usi quando servono) |

---

## Comandi Utili

```bash
# Installa dipendenze
flutter pub get

# Avvia l'app su dispositivo/emulatore
flutter run

# Code generation (dopo Freezed, Drift, Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Code generation in watch mode (rigenera automaticamente)
dart run build_runner watch --delete-conflicting-outputs

# Analisi statica
flutter analyze

# Esegui test
flutter test

# Esegui test specifico
flutter test test/path/to/test.dart
```

---

## Come Procedere

1. Parti dallo **Step 1** e completalo prima di passare al successivo
2. Usa `/project:tutor` per chiedere spiegazioni o revisioni
3. Dopo ogni step, assicurati che l'app compili e giri senza errori
4. Non saltare step — ogni concetto si basa sui precedenti
5. Scrivi codice tu, non chiedere all'AI di scrivere intere feature: imparerai molto di piu

Buon viaggio! 🚀
