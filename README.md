# CV Portfolio (Flutter)

Responsive CV for web and mobile. Visitors read it; the admin signs in on the
same page and edits everything inline. Changes save instantly to Firebase.

- **Open admin login:** lock icon in the footer, or `Ctrl/Cmd + Shift + E`
- **Edit:** tap any outlined text. `Enter` (or `Ctrl/Cmd + Enter` in multi-line fields) or clicking away saves; `Esc` cancels
- **Lists:** `+ Add`, drag handle to reorder, trash icon to delete (with Undo)
- **Languages:** EN / BM toggle. While editing, you edit the language shown. Untranslated fields fall back to English and get an orange outline
- **Extras:** dark mode, PDF download (ATS-friendly, in the current language), preview-as-visitor toggle

Without Firebase configured the app runs in **demo mode** (in-memory, login `admin@demo.dev` / `admin`).

## Run

```bash
flutter pub get
flutter run -d chrome          # or an emulator / device
flutter test
```

After changing models or `.arb` files:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

## Firebase setup (one time)

1. Create a project in the [Firebase console](https://console.firebase.google.com).
2. Connect the app (this overwrites `lib/firebase_options.dart`):
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure --project=<project-id> --platforms=web,android,ios
   ```
3. **Authentication** → enable *Email/Password* → *Users* → add your admin account.
   Then *Settings → User actions* → turn **off** "Enable create (sign-up)".
4. **Firestore** → create database → add a document `admins/<your-UID>` (any field, e.g. `role: "owner"`).
   That document is what makes an account an admin, both in the app and in the security rules.
5. **Storage** → get started (used for the profile photo).
6. Deploy rules and site:
   ```bash
   firebase use <project-id>
   firebase deploy --only firestore:rules,storage
   flutter build web --wasm --release
   firebase deploy --only hosting
   ```

On the first admin login the sample content in `lib/data/seed_data.dart` is
written to `cv/main`; from then on Firestore is the source of truth.

## Security model

- Everyone can read `cv/main`. Only UIDs listed in `/admins` can write (`firestore.rules`).
- Photo uploads: admins only, images only, under 2 MB (`storage.rules`).
- Hiding buttons in the UI is not security. The rules are enforced server-side.

## Structure

```
lib/
  core/                 breakpoints, theme, providers (backend selection, auth, edit mode)
  data/
    models/             freezed models; LText = {en, ms} translatable text
    repositories/       CvRepository / AuthRepository (Firebase + in-memory demo)
    seed_data.dart      sample CV
  features/
    editing/            InlineText, InlineList, InlineDateRange, InlineTags, InlineLevel
    cv/                 page, top bar, optimistic CvController, sections/
    auth/               login dialog
    pdf/                PDF export
    settings/           theme + language (persisted)
  l10n/                 app_en.arb, app_ms.arb
```

## Notes

- `image` is pinned below 4.11 because `pdf` 3.12 caps `archive` below 4.1
  (see `pubspec.yaml`). Remove the pin after upgrading Flutter/`pdf`.
- Update the `<title>` and meta tags in `web/index.html` with your name. Flutter web
  draws on a canvas, so search engines and link previews rely on those tags.
