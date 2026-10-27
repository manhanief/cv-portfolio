import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/localized_text.dart';
import '../../l10n/gen/app_localizations.dart';
import '../settings/settings_providers.dart';
import 'editable_frame.dart';

/// Text that turns into a text field in place when tapped in edit mode.
///
/// Enter (or Ctrl/Cmd+Enter when [multiline]) and tapping elsewhere save;
/// Esc cancels. Saves only when the value actually changed.
class InlineText extends ConsumerStatefulWidget {
  const InlineText({
    super.key,
    required this.value,
    required this.onSave,
    this.placeholder = '',
    this.style,
    this.multiline = false,
    this.validator,
    this.maxLength,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.isFallback = false,
    this.viewBuilder,
  });

  final String value;
  final ValueChanged<String> onSave;
  final String placeholder;
  final TextStyle? style;
  final bool multiline;
  final String? Function(String value)? validator;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextAlign textAlign;

  /// True when [value] is borrowed from another language.
  final bool isFallback;

  /// Custom read-only rendering (bullets, links…). Defaults to plain [Text].
  final Widget Function(BuildContext context, String value)? viewBuilder;

  @override
  ConsumerState<InlineText> createState() => _InlineTextState();
}

class _InlineTextState extends ConsumerState<InlineText> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  bool _active = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (!_focus.hasFocus && _active) _commit(fromBlur: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _start() {
    setState(() {
      _active = true;
      _error = null;
      _controller.text = widget.value;
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: widget.value.length);
    });
  }

  void _cancel() => setState(() {
        _active = false;
        _error = null;
      });

  void _commit({bool fromBlur = false}) {
    if (!_active) return;
    final text =
        widget.multiline ? _controller.text.trimRight() : _controller.text.trim();
    final error = widget.validator?.call(text);
    if (error != null) {
      // Leaving the field with an invalid value reverts instead of trapping focus.
      if (fromBlur) return _cancel();
      setState(() => _error = error);
      _focus.requestFocus();
      return;
    }
    setState(() => _active = false);
    if (text != widget.value) widget.onSave(text);
  }

  @override
  Widget build(BuildContext context) {
    final editing = ref.watch(isEditingProvider);
    final style = widget.style ?? DefaultTextStyle.of(context).style;
    final l10n = AppLocalizations.of(context);

    if (!editing) {
      if (widget.value.isEmpty) return const SizedBox.shrink();
      return widget.viewBuilder?.call(context, widget.value) ??
          Text(widget.value, style: style, textAlign: widget.textAlign);
    }

    if (_active) {
      return CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): _cancel,
          if (widget.multiline) ...{
            const SingleActivator(LogicalKeyboardKey.enter, control: true):
                _commit,
            const SingleActivator(LogicalKeyboardKey.enter, meta: true):
                _commit,
          },
        },
        child: TextField(
          controller: _controller,
          focusNode: _focus,
          autofocus: true,
          style: style,
          textAlign: widget.textAlign,
          maxLength: widget.maxLength,
          keyboardType: widget.multiline
              ? TextInputType.multiline
              : widget.keyboardType,
          minLines: widget.multiline ? 3 : 1,
          maxLines: widget.multiline ? null : 1,
          textInputAction:
              widget.multiline ? TextInputAction.newline : TextInputAction.done,
          onSubmitted: widget.multiline ? null : (_) => _commit(),
          onTapOutside: (_) => _focus.unfocus(),
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.placeholder,
            errorText: _error,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(),
          ),
        ),
      );
    }

    final empty = widget.value.isEmpty;
    final display = empty
        ? Text(
            widget.placeholder,
            textAlign: widget.textAlign,
            style: style.copyWith(
              color: Theme.of(context).colorScheme.outline,
              fontStyle: FontStyle.italic,
            ),
          )
        : widget.viewBuilder?.call(context, widget.value) ??
            Text(widget.value, style: style, textAlign: widget.textAlign);

    return EditableFrame(
      onTap: _start,
      warning: widget.isFallback,
      tooltip: widget.isFallback ? l10n.notTranslated : null,
      semanticLabel: widget.placeholder,
      child: SizedBox(width: double.infinity, child: display),
    );
  }
}

/// [InlineText] bound to a translatable value in the current content language.
class InlineLText extends ConsumerWidget {
  const InlineLText({
    super.key,
    required this.value,
    required this.onSave,
    this.placeholder = '',
    this.style,
    this.multiline = false,
    this.validator,
    this.textAlign = TextAlign.start,
    this.viewBuilder,
  });

  final LText value;
  final ValueChanged<LText> onSave;
  final String placeholder;
  final TextStyle? style;
  final bool multiline;
  final String? Function(String value)? validator;
  final TextAlign textAlign;
  final Widget Function(BuildContext context, String value)? viewBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(contentLanguageProvider);
    return InlineText(
      value: value.tr(lang),
      isFallback: value.isFallbackFor(lang),
      onSave: (text) => onSave(value.put(lang, text)),
      placeholder: placeholder,
      style: style,
      multiline: multiline,
      validator: validator,
      textAlign: textAlign,
      viewBuilder: viewBuilder,
    );
  }
}

abstract final class Validators {
  static String? Function(String) required(AppLocalizations l10n) =>
      (v) => v.isEmpty ? l10n.fieldRequired : null;

  static String? Function(String) url(AppLocalizations l10n) => (v) {
        if (v.isEmpty) return null;
        final uri = Uri.tryParse(v);
        final ok = uri != null &&
            (uri.scheme == 'https' || uri.scheme == 'http') &&
            uri.host.isNotEmpty;
        return ok ? null : l10n.invalidUrl;
      };

  static String? Function(String) email(AppLocalizations l10n) => (v) =>
      v.isEmpty || RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)
          ? null
          : l10n.invalidEmail;
}
