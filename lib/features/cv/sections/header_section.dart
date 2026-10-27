import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/providers.dart';
import '../../../data/models/cv_data.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../editing/inline_list.dart';
import '../../editing/inline_text.dart';
import 'section_card.dart';

/// Photo, name, title, contact details and links.
class HeaderSection extends ConsumerWidget {
  const HeaderSection({super.key, required this.cv, this.centered = false});

  final CvData cv;
  final bool centered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final p = cv.profile;
    final align = centered ? TextAlign.center : TextAlign.start;
    final cross =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: cross,
            children: [
              _Avatar(photoUrl: p.photoUrl, name: p.name),
              const SizedBox(height: 16),
              InlineText(
                value: p.name,
                placeholder: l10n.hName,
                textAlign: align,
                validator: Validators.required(l10n),
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
                onSave: (v) => ref.updateProfile((p) => p.copyWith(name: v)),
              ),
              const SizedBox(height: 4),
              InlineLText(
                value: p.title,
                placeholder: l10n.hTitle,
                textAlign: align,
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.primary),
                onSave: (v) => ref.updateProfile((p) => p.copyWith(title: v)),
              ),
              const SizedBox(height: 20),
              _ContactRow(
                icon: Icons.place_outlined,
                child: InlineText(
                  value: p.location,
                  placeholder: l10n.hLocation,
                  onSave: (v) =>
                      ref.updateProfile((p) => p.copyWith(location: v)),
                ),
              ),
              _ContactRow(
                icon: Icons.mail_outline,
                child: InlineText(
                  value: p.email,
                  placeholder: l10n.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email(l10n),
                  viewBuilder: (_, v) => _Link(v, 'mailto:$v'),
                  onSave: (v) => ref.updateProfile((p) => p.copyWith(email: v)),
                ),
              ),
              _ContactRow(
                icon: Icons.phone_outlined,
                child: InlineText(
                  value: p.phone,
                  placeholder: l10n.hPhone,
                  keyboardType: TextInputType.phone,
                  viewBuilder: (_, v) =>
                      _Link(v, 'tel:${v.replaceAll(RegExp(r'[^\d+]'), '')}'),
                  onSave: (v) => ref.updateProfile((p) => p.copyWith(phone: v)),
                ),
              ),
              const SizedBox(height: 8),
              InlineList<ContactLink>(
                items: cv.links,
                idOf: (l) => l.id,
                spacing: 4,
                create: () => ContactLink(id: uuid.v4()),
                onUpdate: (f) => ref.cv.edit(
                    CvField.links, (d) => d.copyWith(links: f(d.links))),
                itemBuilder: (context, link, onChanged) => _LinkItem(
                  link: link,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.child});
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Theme.of(context).colorScheme.outline),
            const SizedBox(width: 10),
            Expanded(child: child),
          ],
        ),
      );
}

class _Link extends StatelessWidget {
  const _Link(this.text, this.url);
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => openUrl(url),
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      );
}

class _LinkItem extends ConsumerWidget {
  const _LinkItem({required this.link, required this.onChanged});
  final ContactLink link;
  final ValueChanged<ContactLink> onChanged;

  static IconData iconFor(String url) {
    final host = Uri.tryParse(url)?.host ?? '';
    if (host.contains('github')) return Icons.code;
    if (host.contains('linkedin')) return Icons.work_outline;
    return Icons.link;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (!ref.watch(isEditingProvider)) {
      return _ContactRow(
        icon: iconFor(link.url),
        child: _Link(link.label.isEmpty ? link.url : link.label, link.url),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InlineText(
          value: link.label,
          placeholder: l10n.hLabel,
          onSave: (v) => onChanged(link.copyWith(label: v)),
        ),
        const SizedBox(height: 4),
        InlineText(
          value: link.url,
          placeholder: l10n.hUrl,
          keyboardType: TextInputType.url,
          validator: Validators.url(l10n),
          onSave: (v) => onChanged(link.copyWith(url: v)),
        ),
      ],
    );
  }
}

class _Avatar extends ConsumerWidget {
  const _Avatar({required this.photoUrl, required this.name});
  final String? photoUrl;
  final String name;

  static const size = 112.0;

  ImageProvider? get _image {
    final url = photoUrl;
    if (url == null || url.isEmpty) return null;
    // Demo mode stores photos as data URIs.
    if (url.startsWith('data:')) {
      return MemoryImage(UriData.parse(url).contentAsBytes());
    }
    return NetworkImage(url);
  }

  String get _initials => name
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .take(2)
      .map((w) => w[0].toUpperCase())
      .join();

  Future<void> _pick(WidgetRef ref) async {
    // Resize and compress on the device; the result is stored in Firestore.
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 80,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    await ref.cv.uploadPhoto(bytes, file.mimeType ?? 'image/jpeg');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final editing = ref.watch(isEditingProvider);
    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: scheme.primaryContainer,
      foregroundImage: _image,
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: scheme.onPrimaryContainer,
        ),
      ),
    );
    if (!editing) return avatar;

    return Tooltip(
      message: AppLocalizations.of(context).changePhoto,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => _pick(ref),
        child: Stack(
          children: [
            avatar,
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: scheme.primary,
                child: Icon(Icons.photo_camera, size: 18, color: scheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
