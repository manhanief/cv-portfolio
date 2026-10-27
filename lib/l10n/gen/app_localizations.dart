import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ms.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ms'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Curriculum Vitae'**
  String get appTitle;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @certifications.
  ///
  /// In en, this message translates to:
  /// **'Achievements & Certifications'**
  String get certifications;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @itemDeleted.
  ///
  /// In en, this message translates to:
  /// **'Item deleted'**
  String get itemDeleted;

  /// No description provided for @adminLogin.
  ///
  /// In en, this message translates to:
  /// **'Admin login'**
  String get adminLogin;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @editing.
  ///
  /// In en, this message translates to:
  /// **'Editing'**
  String get editing;

  /// No description provided for @editingLanguage.
  ///
  /// In en, this message translates to:
  /// **'Editing {language} content'**
  String editingLanguage(String language);

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get saving;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save: {error}'**
  String saveFailed(String error);

  /// No description provided for @downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get downloadPdf;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleTheme;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switchLanguage;

  /// No description provided for @notTranslated.
  ///
  /// In en, this message translates to:
  /// **'Not translated yet — showing English'**
  String get notTranslated;

  /// No description provided for @demoMode.
  ///
  /// In en, this message translates to:
  /// **'Demo mode: Firebase is not configured, changes are not persisted. Login: admin@demo.dev / admin'**
  String get demoMode;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidCredentials;

  /// No description provided for @notAuthorized.
  ///
  /// In en, this message translates to:
  /// **'This account is not an administrator'**
  String get notAuthorized;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL (https://…)'**
  String get invalidUrl;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalidEmail;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose date…'**
  String get chooseDate;

  /// No description provided for @dragToReorder.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get dragToReorder;

  /// No description provided for @addTag.
  ///
  /// In en, this message translates to:
  /// **'Add…'**
  String get addTag;

  /// No description provided for @skillLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level} of 5'**
  String skillLevel(int level);

  /// No description provided for @hName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get hName;

  /// No description provided for @hTitle.
  ///
  /// In en, this message translates to:
  /// **'Job title'**
  String get hTitle;

  /// No description provided for @hSummary.
  ///
  /// In en, this message translates to:
  /// **'Write a short summary about yourself'**
  String get hSummary;

  /// No description provided for @hLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get hLocation;

  /// No description provided for @hPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get hPhone;

  /// No description provided for @hRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get hRole;

  /// No description provided for @hCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get hCompany;

  /// No description provided for @hDescription.
  ///
  /// In en, this message translates to:
  /// **'Description (one point per line)'**
  String get hDescription;

  /// No description provided for @hSchool.
  ///
  /// In en, this message translates to:
  /// **'School / University'**
  String get hSchool;

  /// No description provided for @hDegree.
  ///
  /// In en, this message translates to:
  /// **'Degree'**
  String get hDegree;

  /// No description provided for @hSkill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get hSkill;

  /// No description provided for @hSkillCategory.
  ///
  /// In en, this message translates to:
  /// **'Category (e.g. Frameworks)'**
  String get hSkillCategory;

  /// No description provided for @hProject.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get hProject;

  /// No description provided for @hUrl.
  ///
  /// In en, this message translates to:
  /// **'https://…'**
  String get hUrl;

  /// No description provided for @hLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get hLabel;

  /// No description provided for @hCertification.
  ///
  /// In en, this message translates to:
  /// **'Certification'**
  String get hCertification;

  /// No description provided for @hIssuer.
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get hIssuer;

  /// No description provided for @hYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get hYear;

  /// No description provided for @hLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get hLanguage;

  /// No description provided for @hProficiency.
  ///
  /// In en, this message translates to:
  /// **'Proficiency'**
  String get hProficiency;

  /// No description provided for @links.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get links;

  /// No description provided for @builtWith.
  ///
  /// In en, this message translates to:
  /// **'Built with Flutter'**
  String get builtWith;

  /// No description provided for @pdfFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not generate PDF'**
  String get pdfFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ms'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ms':
      return AppLocalizationsMs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
