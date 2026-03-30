When building FinFlow widgets, follow these component specifications. Always use shared widgets from `lib/core/widgets/`. All widgets use semantic tokens from `FinFlowColors` — never hardcoded colors. Prefix shared widgets with `FF`.

---

# 1. FFButton

## Primary Button

- **Background:** `accent.default`
- **Text:** `text.onAccent`, `type.headingSm` (14px, weight 600)
- **Padding:** 16px vertical, 24px horizontal
- **Radius:** `radius.sm` (10px)
- **Shadow:** `shadow.accent`
- **States:**
  - Default: as above
  - Pressed: background `accent.pressed`, no shadow
  - Disabled: opacity 0.4, non-interactive
  - Loading: text replaced by white spinner 16px

**Rule:** Only one primary CTA per screen. Never two primary buttons visible simultaneously.

## Secondary Button

- **Background:** transparent
- **Border:** 1px `border.default`
- **Text:** `text.primary`, `type.headingSm`
- **Padding:** 12px vertical, 20px horizontal
- **Radius:** `radius.sm`

**Use:** secondary actions, cancellations, "See all".

## Pill Toggle (Expense/Income)

- **Container:** `radius.full`, padding 4px
- **Active option:** background `accent.default`, text `text.onAccent`
- **Inactive option:** background transparent, border `border.default`, text `text.secondary`
- **Size:** padding 8px 20px, `type.bodySm` (13px, weight 600)

**File:** `lib/core/widgets/ff_button.dart`

---

# 2. FFCard

## Standard Card

- **Background:** `bg.card`
- **Border:** 1px `border.default`
- **Radius:** `radius.md` (16px)
- **Padding:** `space.xl` (20px)
- **Shadow:** `shadow.sm` (optional — only to distinguish from background)

**Internal composition pattern:**
```
[Card]
  ├── Header: title (type.headingSm) + optional action ("See all", accent)
  ├── Spacer: space.md (12-14px)
  └── Content: list, chart, stat grid
```

## Hero Card (Balance, Forecast)

- **Background:** gradient `linear-gradient(135deg, accent.default, accent.pressed)`
- **Radius:** `radius.md`
- **Padding:** 28px 24px
- **Text:** all white, display font for large number
- **Decoration:** 1-2 circles `rgba(255,255,255,0.08)` overlapping for depth

## Stat Box

- **Background:** `bg.cardAlt`
- **Radius:** `radius.sm`
- **Padding:** 14px
- **Layout:** vertical, centered
- **Label:** `type.caption`, `text.muted`
- **Value:** `type.headingMd` or `type.displaySm` (depends on importance), semantic color

**File:** `lib/core/widgets/ff_card.dart`

---

# 3. FFListItem (Transaction / Payment)

```
[ListItem]  padding: 10px 4px
  ├── Icon Container: 36x36px, radius.xs, bg cardAlt, emoji/icon centered
  ├── Content (flex:1)
  │     ├── Title: type.bodyMd, weight 500, text.primary
  │     └── Subtitle: type.caption, text.muted ("Category · Date")
  └── Amount: type.bodyMd, weight 600, semantic color (positive/negative)
```

- **Separator:** 1px `border.default` between items (not on last)
- **Touch target:** minimum height 48px
- **Press state:** background `bg.cardAlt` with 150ms transition

**File:** `lib/core/widgets/ff_list_item.dart`

---

# 4. FFInput

## Standard Input

- **Background:** `bg.cardAlt`
- **Border:** 1px `border.default`
- **Radius:** `radius.xs` (6px)
- **Padding:** 10px 14px
- **Text:** `type.bodyMd`, `text.primary`
- **Placeholder:** `type.bodyMd`, `text.muted`
- **Label (above):** `type.caption`, `text.muted`, margin-bottom 6px
- **States:**
  - Focus: border `accent.default`, light accent shadow
  - Error: border `semantic.negative`, error label below in `type.captionXs`, `semantic.negative`
  - Disabled: opacity 0.5

## Amount Input (special)

- **Layout:** centered, no visible border
- **Currency symbol:** `type.displayMd`, `text.muted`, weight 300
- **Value:** `type.displayLg`, `text.primary`, Instrument Serif font
- **Label above:** `type.overline`, uppercase, `text.muted`

**File:** `lib/core/widgets/ff_input.dart`

---

# 5. FFCategoryChip

- **Layout:** centered column (icon above, label below)
- **Grid:** 4 columns
- **Padding:** 12px 4px
- **Radius:** `radius.sm`
- **Default:** background `bg.cardAlt`, border 2px transparent
- **Selected:** background `accent.bg`, border 2px `accent.default`
- **Icon:** 22px (emoji in mockups, SVG icon in production)
- **Label:** `type.captionXs`, secondary by default, accent if selected

**File:** `lib/core/widgets/ff_category_chip.dart`

---

# 6. FFToggle

- **Track:** 48x28px, `radius.full`
  - Off: background `bg.surface`
  - On: background `accent.default`
- **Thumb:** 22x22px, white circle, shadow `0 1px 3px rgba(0,0,0,0.15)`
- **Transition:** 200ms ease

**File:** `lib/core/widgets/ff_toggle.dart`

---

# 7. FFCalendarDayCell

- **Size:** evenly distributed on 7-column grid
- **Padding:** 8px 0 vertical
- **Text:** `type.bodySm` (13px)
- **Radius:** `radius.xs`
- **States:**
  - Default: weight 400, `text.secondary`
  - Has payment: weight 600, `text.primary` + 5px circle indicator below (semantic color)
  - Selected: background `accent.default`, white text, weight 700, no indicator
  - Today: border 1px `accent.default`, not filled (unless also selected)

**File:** `lib/core/widgets/ff_calendar_day_cell.dart`

---

# 8. FFAlert

- **Layout:** row with icon (18px) + content (title + description)
- **Gap:** `space.md`
- **Padding:** 14px 18px
- **Radius:** `radius.sm`
- **Variants:**
  - Danger: bg `semantic.negativeBg`, border 1px negative at 20% opacity, title `semantic.negative`
  - Warning: bg `semantic.warningBg`, border 1px warning at 20%, title `semantic.warning`
  - Success: bg `semantic.positiveBg`, border 1px positive at 20%, title `semantic.positive`
  - Info: bg `accent.bg`, border 1px accent at 20%, title `accent.default`
- **Title:** `type.bodySm`, weight 600
- **Description:** `type.caption`, `text.secondary`

**File:** `lib/core/widgets/ff_alert.dart`

---

# 9. FFBottomNav

- **Background:** `bg.card` with gradient fade from top (transparent → solid)
- **Border top:** 1px `border.default`
- **Padding:** 10px 8px 20px (20px bottom for safe area)
- **Item:**
  - Icon: 18-22px
  - Label: `type.captionXs` (10px)
  - Inactive: opacity 0.5, `text.muted`
  - Active: opacity 1, `accent.default`, weight 600
  - Transition: 150ms ease

**File:** `lib/core/widgets/ff_bottom_nav.dart`

---

# 10. FFMiniForecastBar

- **Layout:** row — emoji (20px) + content (label + value) + action link
- **Background:** `bg.card`
- **Border:** 1px `border.default`
- **Radius:** `radius.sm`
- **Padding:** 14px 18px
- **Label:** `type.caption`, `text.secondary`
- **Value:** `type.bodyMd`, weight 600, semantic color
- **Link:** `type.caption`, weight 600, `accent.default`

**File:** `lib/core/widgets/ff_mini_forecast_bar.dart`

---

# 11. FFProgressBar (Spending Categories)

- **Container:** `radius.xs`, height 8px, overflow hidden, row layout
- **Segments:** proportional width (%), semantic or accent color, opacity 0.8
- **Legend below:** 2-column grid, 8px dot + label `type.bodySm` secondary + value `type.bodySm` weight 600

**File:** `lib/core/widgets/ff_progress_bar.dart`

---

# Widget Conventions

- All widgets should be `const`-constructible where possible
- Use `FinFlowColors` from context — never hardcoded `Color()` values
- Accept callbacks, not state — parent manages state via Riverpod
- Prefix all shared widgets with `FF` (e.g., `FFButton`, `FFCard`)
- Document public API with `///` doc comments
- One widget per file in `lib/core/widgets/`
