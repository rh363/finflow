# CLAUDE.md

This file provides guidance to Claude Code when working with the FinFlow project.

## What is FinFlow

Personal finance app focused on **recurring payments**, **long-term forecasting (6-24 months)**, and **AI-powered insights**, with a **privacy-first** architecture for the European market (Italy primary). Local-first: financial data never leaves the device in readable form.

**Business model:** Freemium (free core + Premium at 4.99/month or 39.99/year).

## Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Mobile App | Flutter (Dart) | Cross-platform iOS/Android |
| State Management | Riverpod (code-gen) | Reactive, type-safe state |
| Local DB | Drift + SQLCipher | Encrypted SQLite, type-safe queries |
| Navigation | GoRouter | Declarative routing |
| Fonts | google_fonts | Instrument Serif + DM Sans |
| Charts | fl_chart | Interactive financial charts |
| Models | Freezed + json_serializable | Immutable data classes |
| Localization | intl (it_IT primary) | Number/date formatting |
| Icons | Lucide Icons | Consistent icon set |
| Backend (Phase 3+) | Go (Gin/Echo) | Sync, Open Banking proxy |
| AI (Phase 5+) | TFLite / ONNX Runtime | On-device inference |

## Architecture Principles

- **Local-first**: all financial data in encrypted SQLite, no mandatory server
- **Privacy-first**: on-device ML, E2E encrypted sync, no data leaves device without consent
- **Feature-first clean architecture**: `lib/features/<feature>/{data,domain,presentation}`
- **Reactive pipeline**: Drift DB → Riverpod providers → UI
- **Single source of truth**: Drift DB is the canonical store
- **Theme-ready**: semantic tokens only, never raw color/font values — supports Glacier (light) and future Obsidian (dark)

## Project Structure

```
lib/
├── app.dart                        # MaterialApp + GoRouter + ProviderScope
├── main.dart                       # Entry point
├── core/
│   ├── theme/
│   │   ├── finflow_theme.dart      # ThemeData builder
│   │   ├── finflow_colors.dart     # ThemeExtension<FinFlowColors>
│   │   ├── finflow_typography.dart # TextStyle constants
│   │   ├── finflow_spacing.dart    # Spacing constants
│   │   ├── finflow_radius.dart     # BorderRadius constants
│   │   └── finflow_shadows.dart    # BoxShadow constants
│   ├── widgets/                    # Shared widgets (ff_button, ff_card, ff_input, etc.)
│   ├── database/                   # Drift DB setup, DAOs, tables
│   ├── router/                     # GoRouter configuration
│   ├── constants/                  # App-wide constants
│   └── utils/                      # Formatters, validators
├── features/
│   ├── dashboard/
│   │   ├── data/                   # Repositories, data sources
│   │   ├── domain/                 # Entities, use cases
│   │   └── presentation/          # Screens, widgets, providers
│   ├── transactions/
│   ├── recurring/
│   ├── accounts/
│   ├── categories/
│   ├── forecast/
│   ├── settings/
│   └── onboarding/
└── l10n/                           # Localizations
```

## Development Conventions

- **Language**: communicate with the user in **Italian**; all code, commit messages, variable/class/function names in **English**
- **File naming**: `snake_case.dart` for files, `PascalCase` for classes
- **Riverpod**: prefer `@riverpod` code-gen annotation, otherwise explicit providers
- **Models**: use Freezed for immutable data classes with `copyWith` and serialization
- **Database**: one DAO per feature, tables defined in `core/database/tables/`
- **Widgets**: shared widgets in `core/widgets/` with `FF` prefix (e.g., `FFButton`, `FFCard`)
- **Tests**: unit tests under `test/` mirroring `lib/` structure, test files next to source equivalent

## Design System

The design system is documented in three slash commands:

- `/project:finflow-theme` — Design tokens: colors, typography, spacing, radius, shadows
- `/project:finflow-components` — Component specifications: structure, variants, states, usage
- `/project:finflow-patterns` — Layout patterns, empty/loading/error states, financial color rules, number formatting

**Key rule**: never use raw `Color()` or font values. Always access semantic tokens via `Theme.of(context).extension<FinFlowColors>()!` or the convenience extension `context.ffColors`.

## Commands

```bash
flutter pub get                                              # Install dependencies
flutter run                                                  # Run on connected device
flutter test                                                 # Run all tests
flutter analyze                                              # Static analysis
dart run build_runner build --delete-conflicting-outputs     # Code gen (Freezed, Drift, Riverpod)
```

## Backlog

Full product backlog with phases 0-6 is tracked in `docs/backlog.md`.
Current phase: **Phase 0 — Foundation & Design**.
