import 'package:flutter/material.dart';

/// Visual affordance around anything editable in edit mode: a subtle outline
/// that strengthens on hover/focus, with tap and keyboard activation.
class EditableFrame extends StatefulWidget {
  const EditableFrame({
    super.key,
    required this.child,
    required this.onTap,
    this.tooltip,
    this.semanticLabel,
    this.warning = false,
  });

  final Widget child;
  final VoidCallback onTap;
  final String? tooltip;
  final String? semanticLabel;

  /// Highlights content needing attention (e.g. untranslated text).
  final bool warning;

  @override
  State<EditableFrame> createState() => _EditableFrameState();
}

class _EditableFrameState extends State<EditableFrame> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = widget.warning ? scheme.tertiary : scheme.primary;
    Widget frame = Semantics(
      button: true,
      label: widget.semanticLabel,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (h) => setState(() => _hover = h),
        borderRadius: BorderRadius.circular(6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: _hover ? base.withValues(alpha: 0.06) : null,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: base.withValues(alpha: _hover ? 0.7 : 0.25),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
    if (widget.tooltip != null) {
      frame = Tooltip(message: widget.tooltip!, child: frame);
    }
    return frame;
  }
}
