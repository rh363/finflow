import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_radius.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';

class FFInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const FFInput({
    this.label,
    this.hint,
    this.onChanged,
    this.controller,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _FFInputState();
  }
}

class _FFInputState extends State<FFInput> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.ffColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: FFTypography.caption.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          decoration: BoxDecoration(
            color: colors.bgCardAlt,
            border: Border.all(
              width: 1,
              color: _isFocused ? colors.accentDefault : colors.borderDefault,
            ),
            borderRadius: FFRadius.xs,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            style: FFTypography.bodyMd.copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: FFTypography.bodyMd.copyWith(color: colors.textMuted),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
