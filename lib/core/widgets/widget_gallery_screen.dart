import 'package:finflow_app/core/theme/finflow_shadows.dart';
import 'package:finflow_app/core/theme/finflow_spacing.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:finflow_app/core/widgets/ff_button.dart';
import 'package:finflow_app/core/widgets/ff_card.dart';
import 'package:finflow_app/core/widgets/ff_input.dart';
import 'package:finflow_app/core/widgets/ff_list_item.dart';
import 'package:flutter/material.dart';

class WidgetGalleryScreen extends StatelessWidget {
  const WidgetGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Gallery')),
      body: ListView(
        padding: const EdgeInsets.all(FFSpacing.xl),
        children: [
          _section('FFButton', [
            FFButton(
              label: 'primario',
              variant: FFButtonVariant.primary,
              onPressed: () {},
            ),
            FFButton(
              label: 'secondario',
              variant: FFButtonVariant.secondary,
              onPressed: () {},
            ),
            const FFButton(label: 'primario disabilitato'),
            const FFButton(
              label: 'secondario disabilitato',
              variant: FFButtonVariant.secondary,
            ),
          ]),
          _section('FFCard', [
            const FFCard(child: Text('card senza ombra')),
            const FFCard(
              shadow: FFShadows.sm,
              child: Text('card con ombra sm'),
            ),
            const FFCard(
              shadow: FFShadows.md,
              child: Text('card con ombra md'),
            ),
            const FFCard(
              shadow: FFShadows.lg,
              child: Text('card con ombra lg'),
            ),
          ]),
          _section('FFListItem', [
            const FFListItem(
              title: 'Palestra',
              subtitle: 'Salute · 15 Mar',
              amount: '-29,99 €',
              isPositive: false,
              icon: Icons.sports_gymnastics,
            ),
            const FFListItem(
              title: 'Stipendio',
              subtitle: 'Lavoro · 01 Mar',
              amount: '+2.450,00 €',
              isPositive: true,
              icon: Icons.attach_money,
            ),
            const FFListItem(
              title: 'Netflix (no icona)',
              subtitle: 'Abbonamento mensile',
              amount: '-15,99 €',
              isPositive: false,
            ),
          ]),
          _section("FFInput", [
            const FFInput(label: "Nome", hint: "Inserisci il nome"),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: FFSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: FFSpacing.md),
            child: Text(title, style: FFTypography.headingLg),
          ),
          ...children.expand(
            (child) => [child, const SizedBox(height: FFSpacing.md)],
          ),
        ],
      ),
    );
  }
}
