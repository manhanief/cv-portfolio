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

## Firebase

Live site: **https://esman-hanief.web.app** (project `test-4e52f`, hosting site `esman-hanief`).
Firestore rules and hosting are already deployed. Remaining one-time steps in the
[Firebase console](https://console.firebase.google.com/project/test-4e52f):

1. **Authentication** → *Get started* → enable **Email/Password**.
2. *Users* → **Add user** with your admin email and a strong password. Copy the **User UID**.
3. *Settings → User actions* → turn **off** "Enable create (sign-up)" so nobody else can register.
4. **Firestore Database** → *Start collection* `admins` → document ID = your **UID** → any field (e.g. `role: "owner"`).
   That document is what makes an account an admin, in the app and in the security rules.
5. Open the site → lock icon (or `Ctrl/Cmd + Shift + E`) → sign in. Your first login copies
   `lib/data/seed_data.dart` into `cv/main`; from then on, edit on the page.

Profile photos are stored inline in the CV document (resized to ~400px, max 300 KB)
so the project stays on the free Spark plan. Cloud Storage would require Blaze.

### Automatic deploys (GitHub Actions)

`.github/workflows/deploy.yml` runs analyze → test → build on every push and PR.
Pushes to `main` deploy to the live site; PRs get a 7-day preview URL. To enable deploys,
add a service account key once:

1. Firebase console → *Project settings* → *Service accounts* → **Generate new private key**.
2. `gh secret set FIREBASE_SERVICE_ACCOUNT < path/to/key.json`, then **delete the key file**.

### Manual deploy

```bash
flutter build web --release && firebase deploy --only hosting
firebase deploy --only firestore:rules     # after editing firestore.rules
```

### iOS

Not configured yet (flutterfire needs the `xcodeproj` gem). Until then iOS runs in demo mode.

```bash
gem install xcodeproj
flutterfire configure --project=test-4e52f --platforms=web,android,ios
```

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
