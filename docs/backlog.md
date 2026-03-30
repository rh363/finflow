# FinFlow — Product Backlog

**Last updated:** March 2026
**Current phase:** Phase 0 — Foundation & Design

## Legend

**Priority:** Must = required for phase release | Should = high value, not blocking | Could = nice to have
**Status:** `backlog` | `in-progress` | `done` | `blocked`

---

## Phase 0 — Foundation & Design (4-6 weeks)

**Goal:** Project setup, design system, validated mockups, defined architecture. No product code.

### Design & UX

| ID | Task | Deliverable | Status |
|----|------|------------|--------|
| P0-D01 | UX Research: interview 5-10 target users | Persona cards, pain points map | backlog |
| P0-D02 | Define Design System: colors, typography, base components | Design tokens file + component library | backlog |
| P0-D03 | Low-fidelity wireframes: main flows (onboarding, dashboard, recurring, forecast) | Clickable wireframe kit | backlog |
| P0-D04 | High-fidelity mockups: 8-12 key screens | Figma mockup with interactive prototype | backlog |
| P0-D05 | Mockup user testing: 3-5 users | Feedback report + iterations | backlog |
| P0-D06 | Icons and illustrations definition | Exportable SVG asset kit | backlog |

### Technical Setup

| ID | Task | Status |
|----|------|--------|
| P0-T01 | Init Flutter project: clean architecture (feature-first), Riverpod, GoRouter, Drift setup | backlog |
| P0-T02 | Init Go backend: module structure, Gin/Echo setup, Dockerfile, health check endpoint | backlog |
| P0-T03 | Setup CI/CD: GitHub Actions — lint + test Flutter, lint + test Go, build APK/IPA | backlog |
| P0-T04 | SQLCipher integration: POC of encrypted local DB with Drift + SQLCipher FFI | backlog |
| P0-T05 | ADR (Architecture Decision Records): document choices (local-first, E2E sync, open banking proxy) | backlog |

---

## Phase 1 — MVP Core (6-8 weeks)

**Goal:** Working app with transaction management and recurring payments. Release on TestFlight/Internal Testing.
**Validation:** Can the user track recurring expenses and understand how much they have left to spend?

### User Stories

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| F1-01 | As a user, I want to add transactions manually (amount, category, date, notes) | Must | backlog |
| F1-02 | As a user, I want to create recurring payments with flexible frequency (monthly, bimonthly, quarterly, annual, custom) | Must | backlog |
| F1-03 | As a user, I want to see a visual calendar with all future recurring payments | Must | backlog |
| F1-04 | As a user, I want a dashboard with current balance, month expenses, and upcoming payments | Must | backlog |
| F1-05 | As a user, I want to categorize transactions (home, transport, food, leisure, health, etc.) | Must | backlog |
| F1-06 | As a user, I want to import transactions from my bank's CSV file | Should | backlog |
| F1-07 | As a user, I want to manage multiple accounts (checking, card, cash) | Should | backlog |
| F1-08 | As a user, I want to search and filter transactions by date, category, amount | Should | backlog |
| F1-09 | As a user, I want a guided onboarding that helps me configure my recurring payments | Must | backlog |
| F1-10 | As a user, I want my data encrypted locally without needing an account | Must | backlog |

### Technical Tasks

| ID | Task | Status |
|----|------|--------|
| F1-T01 | Implement Drift schema: accounts, transactions, recurring_payments, categories | backlog |
| F1-T02 | Recurring engine: scheduler that generates future transactions from defined patterns | backlog |
| F1-T03 | Modular CSV parser: templates for major Italian banks (Intesa, UniCredit, N26, Revolut) | backlog |
| F1-T04 | Custom calendar widget with payment indicators | backlog |
| F1-T05 | Responsive light/dark theme | backlog |

---

## Phase 2 — Forecasting Engine (4-6 weeks)

**Goal:** Financial projections at 6-24 months based on recurring + spending patterns. First public release (beta).
**Validation:** Are projections perceived as useful and accurate? Does the user make decisions based on them?

### User Stories

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| F2-01 | As a user, I want to see a projection of my balance for the next 6 months based on recurring and average spending | Must | backlog |
| F2-02 | As a user, I want to create what-if scenarios (e.g., 'if I take a mortgage of 800/month') | Must | backlog |
| F2-03 | As a user, I want a timeline chart with safe zone vs risk zone | Must | backlog |
| F2-04 | As a user, I want alerts if the forecast shows negative balance in the next 3 months | Must | backlog |
| F2-05 | As a user, I want to extend the forecast up to 24 months | Should | backlog |
| F2-06 | As a user, I want to see the estimated variation of my net worth over time | Should | backlog |
| F2-07 | As a user, I want to compare scenarios side-by-side | Could | backlog |
| F2-08 | As a user, I want the forecast to consider seasonal expenses (Christmas, vacations, taxes) | Should | backlog |

### Technical Tasks

| ID | Task | Status |
|----|------|--------|
| F2-T01 | Forecasting engine: projections based on weighted moving average + recurring schedule | backlog |
| F2-T02 | Scenario manager: CRUD scenarios with modifiable parameters, local persistence | backlog |
| F2-T03 | Chart library: fl_chart for interactive timeline charts with colored zones | backlog |
| F2-T04 | Local notification service for forecast alerts | backlog |
| F2-T05 | First public beta on TestFlight + Google Play Internal | backlog |

---

## Phase 3 — Backend & Sync (4-5 weeks)

**Goal:** Minimal Go backend for multi-device sync and Open Banking preparation. User account introduction.
**Validation:** Does sync work transparently? Does the user trust the privacy model?

### User Stories

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| F3-01 | As a user, I want to create an account (email + password or magic link) to enable sync | Must | backlog |
| F3-02 | As a user, I want to sync data between phone and tablet with E2E encryption | Must | backlog |
| F3-03 | As a user, I want sync to work offline too (queue + reconciliation) | Must | backlog |
| F3-04 | As a user, I want to use the app without an account (pure local mode) | Must | backlog |
| F3-05 | As a user, I want to export all my data in JSON/CSV at any time | Must | backlog |
| F3-06 | As a user, I want to delete my account and all server data with one click | Must | backlog |

### Technical Tasks

| ID | Task | Status |
|----|------|--------|
| F3-T01 | Go backend: auth service (JWT + refresh token), user CRUD, delete cascade | backlog |
| F3-T02 | Sync protocol: CRDT-based or operational transform for conflict merge | backlog |
| F3-T03 | E2E encryption layer: key derived from user password, server sees only opaque blob | backlog |
| F3-T04 | Deploy on Fly.io with multi-stage Dockerfile (Go binary ~10MB) | backlog |
| F3-T05 | Minimal PostgreSQL for user metadata (no financial data) | backlog |
| F3-T06 | Rate limiting + API versioning | backlog |

---

## Phase 4 — Open Banking & Premium (4-6 weeks)

**Goal:** Open Banking integration, freemium model launch, first monetization.
**Validation:** Are users willing to pay? Does bank sync reduce churn?

### User Stories

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| F4-01 | As a user, I want to connect my bank account to import transactions automatically | Must | backlog |
| F4-02 | As a user, I want imported transactions to be auto-categorized | Must | backlog |
| F4-03 | As a user, I want recurring payments to be detected automatically from transactions | Must | backlog |
| F4-04 | As a free user, I want to use basic features without limitations | Must | backlog |
| F4-05 | As a user, I want to subscribe to Premium via in-app purchase | Must | backlog |
| F4-06 | As a user, I want to know exactly what data is shared with the bank and provider | Must | backlog |
| F4-07 | As a user, I want to disconnect my bank account and delete imported data | Must | backlog |

### Technical Tasks

| ID | Task | Status |
|----|------|--------|
| F4-T01 | Open Banking proxy in Go: OAuth2 flow with Nordigen (free) as initial provider | backlog |
| F4-T02 | Transaction enrichment: merchant recognition, rule-based + ML categorization | backlog |
| F4-T03 | Recurring detection algorithm: pattern matching on transactions with similar amount and merchant | backlog |
| F4-T04 | In-app purchase: RevenueCat integration for iOS + Android | backlog |
| F4-T05 | Paywall UI with free vs premium comparison | backlog |
| F4-T06 | Privacy dashboard: screen showing exactly what data exists and where | backlog |

---

## Phase 5 — AI Insights (6-8 weeks)

**Goal:** On-device AI for personalized insights. Killer differentiator: intelligence without privacy compromises.
**Validation:** Are insights actionable? Does the user change behavior thanks to suggestions?

### User Stories

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| F5-01 | As a user, I want a weekly report with insights on my spending | Must | backlog |
| F5-02 | As a user, I want to be alerted about anomalous spending compared to my pattern | Must | backlog |
| F5-03 | As a user, I want optimization suggestions (e.g., 'you're paying for 3 similar streaming services') | Must | backlog |
| F5-04 | As a user, I want seasonal predictions based on my history (e.g., 'in December +40%') | Should | backlog |
| F5-05 | As a user, I want a conversational chatbot for questions about my finances | Could | backlog |
| F5-06 | As a user, I want to know that AI runs on my device and no data leaves | Must | backlog |

### Technical Tasks

| ID | Task | Status |
|----|------|--------|
| F5-T01 | Python pipeline: train models on synthetic/anonymous datasets for categorization and anomaly detection | backlog |
| F5-T02 | Export models to TFLite (Android) and CoreML (iOS) via ONNX as intermediate format | backlog |
| F5-T03 | Flutter plugin for on-device inference (tflite_flutter / onnxruntime_flutter) | backlog |
| F5-T04 | Insights engine: rules + ML hybrid for generating actionable suggestions | backlog |
| F5-T05 | Weekly digest notification with personalized summary | backlog |
| F5-T06 | Evaluate local LLM integration (Phi-3 mini quantized) for chatbot — assess feasibility on target devices | backlog |

---

## Phase 6 — Growth & Polish (ongoing)

**Goal:** Scale, localize, add community-requested features.

### Features

| ID | Feature | Priority | Status |
|----|---------|----------|--------|
| F6-01 | Multi-currency with exchange rates | Should | backlog |
| F6-02 | Shared budget with partner | Should | backlog |
| F6-03 | Home screen widget (iOS/Android) — balance + next payment | Should | backlog |
| F6-04 | Apple Watch / WearOS companion | Could | backlog |
| F6-05 | Web app companion (read-only PWA) | Could | backlog |
| F6-06 | Localization: EN, DE, FR, ES | Must | backlog |
| F6-07 | Accessibility WCAG 2.1 AA | Must | backlog |
| F6-08 | App Store Optimization + landing page | Must | backlog |

---

## Business Model

|  | Free | Premium (4.99/month or 39.99/year) |
|--|------|-------------------------------------|
| Manual transactions | Unlimited | Unlimited |
| Recurring payments | Up to 10 | Unlimited |
| Accounts | Up to 2 | Unlimited |
| CSV Import | Yes | Yes |
| Forecasting | 3 months | 24 months + what-if scenarios |
| Multi-device sync | No | E2E encrypted |
| Open Banking | No | Automatic bank sync |
| AI Insights | No | Reports + suggestions + anomalies |
| Multi-currency | No | Yes |
| Data export | CSV | CSV + JSON + PDF report |

---

## Success Metrics

| Phase | KPI | Target |
|-------|-----|--------|
| Phase 0 | Mockups tested with real users | 5+ users, task success rate >80% |
| Phase 1 | Active weekly beta testers | 10-20 weekly active users |
| Phase 1 | Recurring payments configured per user | Average >=5 per user |
| Phase 2 | Users checking forecast weekly | >60% of active users |
| Phase 3 | Users activating sync | >30% of users with account |
| Phase 4 | Free to premium conversion rate | >5% within 30 days |
| Phase 4 | MRR (Monthly Recurring Revenue) | 500+ within 3 months of launch |
| Phase 5 | Users interacting with AI insights | >40% of premium users |
| Phase 5 | NPS (Net Promoter Score) | >40 |

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Open Banking provider changes pricing/API | High | Adapter pattern architecture: easy switch between Nordigen, Tink, Salt Edge |
| On-device AI performance insufficient | Medium | Progressively complex models; fallback to heuristic rules |
| Low adoption in Italian market | High | Parallel launch in more mature EU markets (DE, NL); multi-language from Phase 6 |
| GDPR compliance complexity | Medium | Local-first approach minimizes exposure; pre-launch legal consultation |
| Competitor adds similar features | Medium | Execution speed + community; the combination of 4 pillars is hard to replicate |
| Infrastructure cost grows with users | Low | Minimal Go backend + local data = very low per-user server costs |
