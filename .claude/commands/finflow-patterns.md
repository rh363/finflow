When building FinFlow screens and features, follow these UX and layout patterns. These patterns ensure consistency across the app and align with the design principles: calm first, action-first, progressive disclosure, accessible, theme-ready.

---

# 1. Standard Screen Layout

Every screen follows this vertical structure:

```
[SafeArea]
  ├── Status Bar (system)
  ├── Screen Header
  │     padding: 16px 24px 8px
  │     Title: type.displaySm (Instrument Serif)
  │     Optional subtitle: type.bodySm, text.secondary
  ├── Scrollable Content
  │     padding: 8px 24px (top reduced to stay close to header)
  │     padding-bottom: 90px (space for bottom nav)
  │     gap between cards: 16px
  └── Bottom Navigation (fixed, gradient fade)
```

**Rules:**
- Maximum 1 hero card per screen (the most important datum)
- Maximum 5-7 cards visible in first scroll; consolidate if more
- Scroll is always vertical, never horizontal (exception: future carousel)
- Screen horizontal padding: always 24px
- Content max width: 428px (iPhone 14 Pro Max reference)

---

# 2. Financial Color Hierarchy

Fundamental rule to avoid confusing the user:

| Context | Color | Example |
|---------|-------|---------|
| Income amount | `semantic.positive` (green) | +2.800,00 (salary) |
| Expense amount | `semantic.negative` (red) | -15,99 (Netflix) |
| Positive balance | `text.primary` (neutral!) | 3.247,52 |
| Balance in risk zone | `semantic.negative` | 850,00 |
| Positive trend | `semantic.positive` | Up arrow, "Growing" |
| Negative trend | `semantic.negative` | Down arrow, "Declining" |
| Projection line | `accent.default` | Forecast line on chart |
| Safe zone | no color / accent bg | Area above threshold |
| Risk zone | `semantic.negativeBg` | Area below threshold |

**Current balance is ALWAYS neutral** (`text.primary`) unless below a user-defined risk threshold. This avoids "everything is red = panic" or "everything is green = false security".

---

# 3. Number Formatting

| Type | Format | Example |
|------|--------|---------|
| Currency (EUR) | Thousands separator: `.` Decimals: `,` | 3.247,52 |
| Negative currency | Minus sign + currency | -15,99 |
| Explicit positive currency | Plus sign + currency | +2.800,00 |
| Percentage | Number + `%` | 48% |
| Short date | `DD MMM YYYY` | 02 Apr 2026 |
| Extended date | `DD MMMM` | 2 Aprile |
| Relative date | "Oggi", "Domani", "Ieri", then absolute | Oggi, 30 Mar |

**Locale:** `it-IT` as default, with fallback to device locale. Use `intl` package in Flutter for all formatting. Always show 2 decimal places for currency amounts.

---

# 4. Empty States

When a section has no data (first launch, no transactions, etc.):

```
[Empty State Container]  centered vertically in card
  ├── Illustration: SVG 120x120px, gray tones + light accent
  ├── Title: type.headingMd, text.primary, centered
  ├── Description: type.bodySm, text.secondary, centered, max 2 lines
  └── CTA: Primary Button or accent link
```

**Variants per screen:**

| Screen | Illustration | Title | CTA |
|--------|-------------|-------|-----|
| Dashboard | Empty wallet | Start tracking | + Add transaction |
| Calendar | Empty calendar | No recurring payments | + Create recurring |
| Forecast | Flat chart | Need more data | Add at least 5 recurring |
| Transaction list | Empty list | No transactions found | Edit filters |

**Rule:** empty state is never just text. Always has an illustration and a CTA. The user must never feel "lost".

---

# 5. Loading States

- **Full screen:** skeleton shimmer on cards (background `bg.cardAlt` with shimmer gradient animation `cardAlt → white → cardAlt`)
- **Single section:** inline skeleton of content rows
- **Action (button):** white spinner 16px replacing text, button disabled
- **Pull to refresh:** circular accent indicator above content

**Shimmer duration:** 1.5s loop, ease-in-out.

**Rule:** never a full-screen spinner. Always skeleton that anticipates content structure — user knows what's coming.

---

# 6. Feedback & Confirmations

## Toast / Snackbar

- **Position:** bottom, above navigation bar, centered
- **Background:** `text.primary` (dark on light theme)
- **Text:** `type.bodySm`, white
- **Radius:** `radius.sm`
- **Padding:** 12px 20px
- **Duration:** 3 seconds, dismiss with swipe
- **Optional action:** "Undo" link in light accent
- **Example:** "Transaction saved" with "Undo" action

## Destructive Confirmation (Delete)

- **Modal bottom sheet:** background `bg.card`, radius.lg top
- **Content:**
  - Warning/danger icon 48px centered
  - Title: `type.headingMd`, centered ("Delete this transaction?")
  - Description: `type.bodySm`, `text.secondary`, centered ("This action cannot be undone")
  - Two full-width buttons: Secondary ("Cancel") + Danger (bg `semantic.negative`, white text, "Delete")
- **Backdrop:** black 50% opacity

---

# 7. Key Screen Compositions

## Dashboard

```
[Screen]
  ├── Header: "Dashboard" (displaySm) + greeting subtitle
  ├── Hero Card: total balance (gradient, displayLg amount)
  ├── Stat Row: 3x Stat Box (month expenses, month income, savings)
  ├── Mini Forecast Bar: projected balance link
  ├── Upcoming Payments Card: next 5 recurring (FFListItem)
  └── Recent Transactions Card: last 5 transactions (FFListItem)
```

## Transaction List

```
[Screen]
  ├── Header: "Transactions" (displaySm)
  ├── Search/Filter Bar: FFInput search + category filter chips
  ├── Grouped List:
  │     ├── Date Header: "Today", "Yesterday", "25 March" (type.caption, text.muted)
  │     └── FFListItem per transaction
  └── FAB: "+" add transaction (accent, radius.full, shadow.accent)
```

## Add Transaction

```
[Screen / Bottom Sheet]
  ├── Pill Toggle: Expense / Income
  ├── Amount Input: centered, large Instrument Serif
  ├── Category Grid: 4-column FFCategoryChip
  ├── Date Picker: inline, defaults to today
  ├── Account Selector: dropdown from accounts
  ├── Notes: optional FFInput
  └── Save Button: full-width FFButton primary
```

## Calendar

```
[Screen]
  ├── Header: "Calendar" (displaySm) + month/year selector
  ├── Week Day Headers: Mon-Sun (type.captionXs, text.muted)
  ├── Day Grid: FFCalendarDayCell with payment indicators
  ├── Selected Day Detail: list of payments for that day (FFListItem)
  └── Monthly Total Card: Stat Box with total upcoming
```

---

# 8. Animation & Transition Patterns

- **Page transitions:** slide from right (forward), slide from left (back)
- **Modal bottom sheets:** slide up with backdrop fade
- **List item additions:** fade + slide in
- **Amount changes:** count-up animation
- **Implicit animations preferred:** `AnimatedContainer`, `AnimatedOpacity` with 200-300ms duration, ease curves
- **Toggle/selection:** 150-200ms ease

---

# 9. Responsive & Safe Area

| Property | Value |
|----------|-------|
| Max content width | 428px (iPhone 14 Pro Max reference) |
| Horizontal padding | 24px fixed |
| Safe area top | Respect `MediaQuery.padding.top` |
| Safe area bottom | Minimum 20px below nav bar + system inset |
| Minimum touch target | 48x48 dp |
| Tablet breakpoint | Not planned for Phase 0-2 (mobile only) |

---

# 10. Accessibility Checklist

- All text/background combinations must pass WCAG 2.1 AA contrast ratios
- Touch targets minimum 48x48 dp
- Screen reader labels on all interactive elements (`Semantics` widget)
- Respect `MediaQuery.textScaleFactor` for Dynamic Type
- No information conveyed by color alone (always pair with icon/text)
- Focus order follows visual reading order
