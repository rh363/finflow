When generating or modifying Flutter code for FinFlow, use the design tokens defined below. **Never use raw Color() values or hardcoded font sizes.** Always reference semantic tokens via `Theme.of(context).extension<FinFlowColors>()!` or the convenience extension `context.ffColors`.

---

# Color Primitives (Glacier Theme)

| Token | Hex | Use |
|-------|-----|-----|
| `color.blue.500` | `#2563EB` | Base accent |
| `color.blue.700` | `#1D4ED8` | Accent pressed/dark |
| `color.blue.100` | `#DBEAFE` | Accent background |
| `color.gray.900` | `#1A1D23` | Primary text |
| `color.gray.500` | `#6B7280` | Secondary text |
| `color.gray.400` | `#9CA3AF` | Muted text / placeholder |
| `color.gray.200` | `#E5E7EB` | Borders |
| `color.gray.100` | `#F0F2F5` | Alt card surface |
| `color.gray.50` | `#F7F8FA` | App background |
| `color.white` | `#FFFFFF` | Primary card surface |
| `color.green.600` | `#059669` | Positive |
| `color.green.100` | `#D1FAE5` | Positive background |
| `color.red.600` | `#DC2626` | Negative / error |
| `color.red.100` | `#FEE2E2` | Negative background |
| `color.amber.600` | `#D97706` | Warning |
| `color.amber.100` | `#FEF3C7` | Warning background |

# Semantic Color Tokens

Components consume ONLY these tokens. Never use primitives directly in widgets.

| Token | Glacier Maps To | Meaning |
|-------|----------------|---------|
| `color.bg.primary` | `gray.50` (#F7F8FA) | App background |
| `color.bg.card` | `white` (#FFFFFF) | Card / elevated surface |
| `color.bg.cardAlt` | `gray.100` (#F0F2F5) | Secondary card / input bg |
| `color.bg.surface` | `#E8ECF1` | Interactive surfaces (toggle off, chip) |
| `color.text.primary` | `gray.900` (#1A1D23) | Main text |
| `color.text.secondary` | `gray.500` (#6B7280) | Descriptive text / labels |
| `color.text.muted` | `gray.400` (#9CA3AF) | Placeholder, hint, disabled |
| `color.text.onAccent` | `white` (#FFFFFF) | Text on accent background |
| `color.accent.default` | `blue.500` (#2563EB) | Primary action, links, selected |
| `color.accent.pressed` | `blue.700` (#1D4ED8) | Pressed / hover state |
| `color.accent.bg` | `blue.100` (#DBEAFE) | Selected element background |
| `color.semantic.positive` | `green.600` (#059669) | Income, positive trends, success |
| `color.semantic.positiveBg` | `green.100` (#D1FAE5) | Positive state background |
| `color.semantic.negative` | `red.600` (#DC2626) | Expenses, errors, critical alerts |
| `color.semantic.negativeBg` | `red.100` (#FEE2E2) | Negative state background |
| `color.semantic.warning` | `amber.600` (#D97706) | Attention, risk zones |
| `color.semantic.warningBg` | `amber.100` (#FEF3C7) | Warning background |
| `color.border.default` | `gray.200` (#E5E7EB) | Card borders, separators, input borders |

# ThemeExtension Implementation

Define `FinFlowColors` as a `ThemeExtension<FinFlowColors>` in `lib/core/theme/finflow_colors.dart`. Include all semantic tokens as fields. Implement `copyWith()` and `lerp()` for theme transitions.

Access pattern:
```dart
// Via ThemeExtension
final colors = Theme.of(context).extension<FinFlowColors>()!;

// Via convenience extension (define in finflow_colors.dart)
extension FFColorsExtension on BuildContext {
  FinFlowColors get ffColors => Theme.of(context).extension<FinFlowColors>()!;
}

// Usage
Container(color: context.ffColors.bgPrimary)
Text('Hello', style: TextStyle(color: context.ffColors.textPrimary))
```

# Typography

**Font pairing:** Instrument Serif (display/numbers) + DM Sans (body/UI). Both via `google_fonts` package.

| Token | Font | Weight | Size | Line Height | Use |
|-------|------|--------|------|-------------|-----|
| `type.displayLg` | Instrument Serif | 700 | 36px | 1.1 | Total balance hero |
| `type.displayMd` | Instrument Serif | 700 | 28px | 1.15 | Forecast titles, transaction amount |
| `type.displaySm` | Instrument Serif | 600 | 22px | 1.2 | Screen header |
| `type.headingLg` | DM Sans | 700 | 20px | 1.25 | Main section titles |
| `type.headingMd` | DM Sans | 600 | 16px | 1.3 | Card titles |
| `type.headingSm` | DM Sans | 600 | 14px | 1.35 | Subtitles, important labels |
| `type.bodyLg` | DM Sans | 400 | 16px | 1.5 | Long body text |
| `type.bodyMd` | DM Sans | 400 | 14px | 1.5 | Standard body text |
| `type.bodySm` | DM Sans | 400 | 13px | 1.45 | Secondary text in lists |
| `type.caption` | DM Sans | 500 | 12px | 1.4 | Small labels, dates, metadata |
| `type.captionXs` | DM Sans | 500 | 11px | 1.35 | Badges, tags, minimal hints |
| `type.overline` | DM Sans | 500 | 12px | 1.4 | Uppercase labels (letter-spacing 0.05em) |

**Flutter TextTheme mapping:**
- `displayLarge/Medium/Small` → Instrument Serif
- Everything else → DM Sans

**Dynamic Type:** all sizes are base values. Respect `MediaQuery.textScaleFactor`. Absolute minimum: no text below 11px after scaling.

# Spacing

Base unit: 4px.

| Token | Value | Typical use |
|-------|-------|-------------|
| `space.2xs` | 2px | Minimum padding, inline icon-text gap |
| `space.xs` | 4px | Gap between tightly related elements |
| `space.sm` | 8px | Standard intra-component gap |
| `space.md` | 12px | Gap between components in same section |
| `space.lg` | 16px | Gap between sections, standard card padding |
| `space.xl` | 20px | Card padding for rich content |
| `space.2xl` | 24px | Screen horizontal margins, gap between cards |
| `space.3xl` | 32px | Hero section padding |
| `space.4xl` | 48px | Macro-section separation |

**Rules:**
- Screen horizontal padding: always `space.2xl` (24px)
- Vertical gap between cards: `space.lg` (16px)
- Card internal padding: `space.xl` (20px)
- Gap between elements in same card: `space.sm` (8px) or `space.md` (12px)

Define in `lib/core/theme/finflow_spacing.dart` as `abstract class FFSpacing` with static const doubles.

# Border Radius

| Token | Value | Use |
|-------|-------|-----|
| `radius.xs` | 6px | Input field, badge, tag |
| `radius.sm` | 10px | Buttons, chip, secondary cards, stat box |
| `radius.md` | 16px | Main cards, modal |
| `radius.lg` | 20px | Bottom sheet, hero card |
| `radius.full` | 9999px | Avatar, indicators, toggle, pill button |

Define in `lib/core/theme/finflow_radius.dart` as `abstract class FFRadius` with static `BorderRadius` constants.

# Elevation / Shadows

| Token | Value | Use |
|-------|-------|-----|
| `shadow.sm` | `0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04)` | Standard card |
| `shadow.md` | `0 4px 12px rgba(0,0,0,0.08)` | Card hover/focus, dropdown |
| `shadow.lg` | `0 8px 24px rgba(0,0,0,0.12)` | Bottom sheet, modal |
| `shadow.accent` | `0 4px 12px {accent}44` | Primary button glow |

Define in `lib/core/theme/finflow_shadows.dart` as `abstract class FFShadows` with static `List<BoxShadow>` constants.

# Iconography

| Property | Value |
|----------|-------|
| Set | Lucide Icons (preferred) or Material Symbols Rounded |
| Stroke | 1.5px (regular), 2px (emphasis) |
| Standard size | 20px (body), 24px (nav/action) |
| Default color | `color.text.secondary` |
| Active color | `color.accent.default` |

Use emoji as category placeholders in development. Replace with custom SVG icons from same set in production.

# File Locations

```
lib/core/theme/
├── finflow_theme.dart        # ThemeData builder (assembles everything)
├── finflow_colors.dart       # ThemeExtension<FinFlowColors> + convenience extension
├── finflow_typography.dart   # TextStyle constants
├── finflow_spacing.dart      # Spacing constants (double)
├── finflow_radius.dart       # BorderRadius constants
└── finflow_shadows.dart      # BoxShadow constants
```
