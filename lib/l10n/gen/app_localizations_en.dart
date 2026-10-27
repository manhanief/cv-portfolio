// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Curriculum Vitae';

  @override
  String get about => 'About';

  @override
  String get experience => 'Experience';

  @override
  String get education => 'Education';

  @override
  String get skills => 'Skills';

  @override
  String get projects => 'Projects';

  @override
  String get certifications => 'Achievements & Certifications';

  @override
  String get languages => 'Languages';

  @override
  String get contact => 'Contact';

  @override
  String get present => 'Present';

  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String get undo => 'Undo';

  @override
  String get itemDeleted => 'Item deleted';

  @override
  String get adminLogin => 'Admin login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get cancel => 'Cancel';

  @override
  String get signOut => 'Sign out';

  @override
  String get editing => 'Editing';

  @override
  String editingLanguage(String language) {
    return 'Editing $language content';
  }

  @override
  String get preview => 'Preview';

  @override
  String get saving => 'Saving…';

  @override
  String get saved => 'Saved';

  @override
  String saveFailed(String error) {
    return 'Could not save: $error';
  }

  @override
  String get downloadPdf => 'Download PDF';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get switchLanguage => 'Switch language';

  @override
  String get notTranslated => 'Not translated yet — showing English';

  @override
  String get demoMode =>
      'Demo mode: Firebase is not configured, changes are not persisted. Login: admin@demo.dev / admin';

  @override
  String get invalidCredentials => 'Invalid email or password';

  @override
  String get notAuthorized => 'This account is not an administrator';

  @override
  String get fieldRequired => 'Required';

  @override
  String get invalidUrl => 'Enter a valid URL (https://…)';

  @override
  String get invalidEmail => 'Enter a valid email';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get chooseDate => 'Choose date…';

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get addTag => 'Add…';

  @override
  String skillLevel(int level) {
    return 'Level $level of 5';
  }

  @override
  String get hName => 'Your name';

  @override
  String get hTitle => 'Job title';

  @override
  String get hSummary => 'Write a short summary about yourself';

  @override
  String get hLocation => 'Location';

  @override
  String get hPhone => 'Phone';

  @override
  String get hRole => 'Role';

  @override
  String get hCompany => 'Company';

  @override
  String get hDescription => 'Description (one point per line)';

  @override
  String get hSchool => 'School / University';

  @override
  String get hDegree => 'Degree';

  @override
  String get hSkill => 'Skill';

  @override
  String get hSkillCategory => 'Category (e.g. Frameworks)';

  @override
  String get hProject => 'Project name';

  @override
  String get hUrl => 'https://…';

  @override
  String get hLabel => 'Label';

  @override
  String get hCertification => 'Certification';

  @override
  String get hIssuer => 'Issuer';

  @override
  String get hYear => 'Year';

  @override
  String get hLanguage => 'Language';

  @override
  String get hProficiency => 'Proficiency';

  @override
  String get links => 'Links';

  @override
  String get builtWith => 'Built with Flutter';

  @override
  String get pdfFailed => 'Could not generate PDF';
}
