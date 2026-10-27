// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Resume';

  @override
  String get about => 'Tentang Saya';

  @override
  String get experience => 'Pengalaman';

  @override
  String get education => 'Pendidikan';

  @override
  String get skills => 'Kemahiran';

  @override
  String get projects => 'Projek';

  @override
  String get certifications => 'Pencapaian & Pensijilan';

  @override
  String get languages => 'Bahasa';

  @override
  String get contact => 'Hubungi';

  @override
  String get present => 'Kini';

  @override
  String get add => 'Tambah';

  @override
  String get delete => 'Padam';

  @override
  String get undo => 'Batal';

  @override
  String get itemDeleted => 'Item dipadam';

  @override
  String get adminLogin => 'Log masuk pentadbir';

  @override
  String get email => 'E-mel';

  @override
  String get password => 'Kata laluan';

  @override
  String get signIn => 'Log masuk';

  @override
  String get cancel => 'Batal';

  @override
  String get signOut => 'Log keluar';

  @override
  String get editing => 'Menyunting';

  @override
  String editingLanguage(String language) {
    return 'Menyunting kandungan $language';
  }

  @override
  String get preview => 'Pratonton';

  @override
  String get saving => 'Menyimpan…';

  @override
  String get saved => 'Disimpan';

  @override
  String saveFailed(String error) {
    return 'Gagal menyimpan: $error';
  }

  @override
  String get downloadPdf => 'Muat turun PDF';

  @override
  String get toggleTheme => 'Tukar tema';

  @override
  String get switchLanguage => 'Tukar bahasa';

  @override
  String get notTranslated => 'Belum diterjemah — memaparkan Bahasa Inggeris';

  @override
  String get demoMode =>
      'Mod demo: Firebase belum dikonfigurasi, perubahan tidak disimpan. Log masuk: admin@demo.dev / admin';

  @override
  String get invalidCredentials => 'E-mel atau kata laluan tidak sah';

  @override
  String get notAuthorized => 'Akaun ini bukan pentadbir';

  @override
  String get fieldRequired => 'Wajib diisi';

  @override
  String get invalidUrl => 'Masukkan URL yang sah (https://…)';

  @override
  String get invalidEmail => 'Masukkan e-mel yang sah';

  @override
  String get changePhoto => 'Tukar gambar';

  @override
  String get chooseDate => 'Pilih tarikh…';

  @override
  String get dragToReorder => 'Seret untuk susun semula';

  @override
  String get addTag => 'Tambah…';

  @override
  String skillLevel(int level) {
    return 'Tahap $level daripada 5';
  }

  @override
  String get hName => 'Nama anda';

  @override
  String get hTitle => 'Jawatan';

  @override
  String get hSummary => 'Tulis ringkasan pendek tentang diri anda';

  @override
  String get hLocation => 'Lokasi';

  @override
  String get hPhone => 'Telefon';

  @override
  String get hRole => 'Jawatan';

  @override
  String get hCompany => 'Syarikat';

  @override
  String get hDescription => 'Penerangan (satu perkara setiap baris)';

  @override
  String get hSchool => 'Sekolah / Universiti';

  @override
  String get hDegree => 'Ijazah';

  @override
  String get hSkill => 'Kemahiran';

  @override
  String get hSkillCategory => 'Kategori (cth. Rangka Kerja)';

  @override
  String get hProject => 'Nama projek';

  @override
  String get hUrl => 'https://…';

  @override
  String get hLabel => 'Label';

  @override
  String get hCertification => 'Sijil';

  @override
  String get hIssuer => 'Penganjur';

  @override
  String get hYear => 'Tahun';

  @override
  String get hLanguage => 'Bahasa';

  @override
  String get hProficiency => 'Tahap penguasaan';

  @override
  String get links => 'Pautan';

  @override
  String get builtWith => 'Dibina dengan Flutter';

  @override
  String get pdfFailed => 'Gagal menjana PDF';
}
