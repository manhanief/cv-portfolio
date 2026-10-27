import 'models/cv_data.dart';

/// Initial CV content. Written to Firestore on the first admin login;
/// after that, edit everything inline on the page.
const seedCv = CvData(
  profile: Profile(
    name: 'Esman Hanief',
    title: {
      'en': 'IT, Software Dev, AI Engineer',
      'ms': 'IT, Pembangun Perisian, Jurutera AI',
    },
    summary: {
      'en': 'IT Executive and System Developer at KPJ Rawang Specialist '
          'Hospital, building internal web systems, Microsoft 365 automation '
          'and AI-powered mobile apps for a regulated healthcare environment. '
          'Completing a Bachelor of Computer Science at UiTM part-time '
          'alongside full-time work.',
      'ms': 'Eksekutif IT dan Pembangun Sistem di KPJ Rawang Specialist '
          'Hospital, membina sistem web dalaman, automasi Microsoft 365 dan '
          'aplikasi mudah alih berkuasa AI untuk persekitaran penjagaan '
          'kesihatan yang dikawal selia. Sedang melengkapkan Ijazah Sarjana '
          'Muda Sains Komputer di UiTM secara separuh masa sambil bekerja '
          'sepenuh masa.',
    },
    location: 'Rawang, Selangor, Malaysia',
    email: 'hanief242@gmail.com',
    phone: '+60 11-3034 3515',
  ),
  links: [
    ContactLink(id: 'github', label: 'GitHub', url: 'https://github.com/manhanief'),
    ContactLink(
      id: 'linkedin',
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/in/esman_hanief',
    ),
  ],
  experience: [
    Experience(
      id: 'kpj',
      role: {
        'en': 'IT Executive / System Developer',
        'ms': 'Eksekutif IT / Pembangun Sistem',
      },
      company: 'KPJ Rawang Specialist Hospital',
      location: 'Rawang, Selangor',
      start: '2023',
      description: {
        'en': 'Architected and deployed 8+ internal web systems (staff '
            'training, health screening, transport booking, event management) '
            'serving 200+ hospital staff daily.\n'
            'Re-engineered the hospital charge code approval process from a '
            'legacy Excel/VBA workflow into a cloud-based multi-level system '
            '(Power Automate, SharePoint Online, Excel Online, Teams/Outlook, '
            'Entra ID) at zero additional cost under existing M365 E3 '
            'licensing.\n'
            'Eliminated critical security flaws (identity spoofing and '
            'hardcoded credentials) by shifting approver authentication to '
            'Entra ID verified sign-in; implemented sequential HOS → Finance → '
            'CEO → IT routing with urgent-handling logic and an append-only '
            'audit trail.\n'
            'Built a License Tracker Power App (SharePoint Lists + Power '
            'Automate) to automate software renewal reminders, removing manual '
            'tracking dependency entirely.\n'
            'Developed the Waste AI Detector mobile app (Flutter + Firebase + '
            'HuggingFace ML) and the TSight staff training system (Laravel + '
            'MySQL).\n'
            'Managed LAN/intranet infrastructure and provided first- and '
            'second-line IT support in a regulated healthcare environment.',
        'ms': 'Mereka bentuk dan melancarkan 8+ sistem web dalaman (latihan '
            'kakitangan, saringan kesihatan, tempahan pengangkutan, pengurusan '
            'acara) yang digunakan oleh 200+ kakitangan hospital setiap hari.\n'
            'Merekayasa semula proses kelulusan kod caj hospital daripada '
            'aliran kerja Excel/VBA lama kepada sistem berbilang peringkat '
            'berasaskan awan (Power Automate, SharePoint Online, Excel Online, '
            'Teams/Outlook, Entra ID) tanpa kos tambahan di bawah lesen M365 '
            'E3 sedia ada.\n'
            'Menghapuskan kelemahan keselamatan kritikal (penyamaran identiti '
            'dan kelayakan berkod keras) dengan memindahkan pengesahan pelulus '
            'kepada log masuk Entra ID yang disahkan; melaksanakan penghalaan '
            'berurutan HOS → Kewangan → CEO → IT dengan logik pengendalian kes '
            'segera dan jejak audit tambah-sahaja.\n'
            'Membina Power App License Tracker (SharePoint Lists + Power '
            'Automate) untuk mengautomasikan peringatan pembaharuan lesen '
            'perisian, menghapuskan kebergantungan pada penjejakan manual '
            'sepenuhnya.\n'
            'Membangunkan aplikasi mudah alih Waste AI Detector (Flutter + '
            'Firebase + HuggingFace ML) dan sistem latihan kakitangan TSight '
            '(Laravel + MySQL).\n'
            'Mengurus infrastruktur LAN/intranet dan menyediakan sokongan IT '
            'barisan pertama dan kedua dalam persekitaran penjagaan kesihatan '
            'yang dikawal selia.',
      },
    ),
  ],
  education: [
    Education(
      id: 'uitm',
      school: 'Universiti Teknologi MARA (UiTM)',
      degree: {
        'en': 'Bachelor of Computer Science',
        'ms': 'Ijazah Sarjana Muda Sains Komputer',
      },
      start: '2022',
      end: '2028',
      description: {
        'en': 'Part-time (weekend classes), Year 4: completing the final year '
            'while working full-time at KPJ Rawang Specialist Hospital.\n'
            'Demonstrates commitment to continuous professional development '
            'alongside a full-time career in IT.',
        'ms': 'Separuh masa (kelas hujung minggu), Tahun 4: sedang '
            'melengkapkan tahun akhir sambil bekerja sepenuh masa di KPJ '
            'Rawang Specialist Hospital.\n'
            'Menunjukkan komitmen terhadap pembangunan profesional berterusan '
            'seiring kerjaya sepenuh masa dalam bidang IT.',
      },
    ),
    Education(
      id: 'uthm',
      school: 'Universiti Tun Hussein Onn Malaysia (UTHM), Parit Raja, Johor',
      degree: {
        'en': 'Diploma in Information Technology (CGPA 3.62)',
        'ms': 'Diploma Teknologi Maklumat (PNGK 3.62)',
      },
      start: '2020',
      end: '2022',
      description: {
        'en': 'Hackathon 2022: designed the UI in Figma and co-developed a '
            'Flood Monitoring System concept.\n'
            'Multimedia Director & MC, PEMBINA: managed a motivation programme '
            'for 32+ SPM students.',
        'ms': 'Hackathon 2022: mereka bentuk UI dalam Figma dan membangunkan '
            'bersama konsep Sistem Pemantauan Banjir.\n'
            'Pengarah Multimedia & Pengacara Majlis, PEMBINA: mengurus program '
            'motivasi untuk 32+ pelajar SPM.',
      },
    ),
  ],
  skills: [
    SkillGroup(
      id: 'lang',
      category: {'en': 'Languages', 'ms': 'Bahasa Pengaturcaraan'},
      items: ['PHP', 'JavaScript', 'Dart (Flutter)', 'HTML5', 'CSS3'],
    ),
    SkillGroup(
      id: 'fw',
      category: {'en': 'Frameworks', 'ms': 'Rangka Kerja'},
      items: ['Laravel', 'Bootstrap 5', 'MVC Architecture', 'Unity'],
    ),
    SkillGroup(
      id: 'ai',
      category: {'en': 'Mobile & AI', 'ms': 'Mudah Alih & AI'},
      items: ['Flutter', 'Firebase', 'HuggingFace ML Models'],
    ),
    SkillGroup(
      id: 'm365',
      category: {'en': 'M365 / Low-Code', 'ms': 'M365 / Kod Rendah'},
      items: [
        'Power Apps',
        'Power Automate',
        'SharePoint Online',
        'Excel Online',
        'Entra ID',
        'Teams',
        'VBA',
      ],
    ),
    SkillGroup(
      id: 'tools',
      category: {'en': 'Tools', 'ms': 'Alatan'},
      items: ['Git', 'GitHub', 'MySQL', 'XAMPP', 'Laragon', 'Railway', 'Figma'],
    ),
    SkillGroup(
      id: 'domain',
      category: {'en': 'Domain', 'ms': 'Domain'},
      items: [
        'Healthcare IT',
        'LAN Infrastructure',
        'IT Support',
        'Process Re-engineering',
      ],
    ),
    SkillGroup(
      id: 'soft',
      category: {'en': 'Soft Skills', 'ms': 'Kemahiran Insaniah'},
      items: [
        'Stakeholder Communication',
        'Technical Documentation',
        'Problem-Solving',
        'Bilingual (Malay / English)',
      ],
    ),
  ],
  projects: [
    Project(
      id: 'chargecode',
      name: 'Charge Code Approval System (M365 Re-engineering)',
      start: '2024',
      end: '2025',
      techStack: [
        'Power Automate',
        'SharePoint Online',
        'Entra ID',
        'Excel Online',
        'Teams/Outlook',
      ],
      description: {
        'en': 'Replaced an insecure Excel/VBA workflow with a cloud-based '
            'sequential approval chain (HOS → Finance → CEO → IT) featuring '
            'service-based routing, multi-item requests, urgent handling, '
            'mobile approvals from any device and an append-only audit trail, '
            'within existing M365 E3 licensing at zero additional cost.\n'
            'Implemented dynamic list-driven role management so personnel '
            'changes require no modifications to the underlying workflow.',
        'ms': 'Menggantikan aliran kerja Excel/VBA yang tidak selamat dengan '
            'rantaian kelulusan berurutan berasaskan awan (HOS → Kewangan → '
            'CEO → IT) yang menampilkan penghalaan mengikut perkhidmatan, '
            'permohonan berbilang item, pengendalian kes segera, kelulusan '
            'mudah alih dari mana-mana peranti dan jejak audit tambah-sahaja, '
            'dalam lesen M365 E3 sedia ada tanpa kos tambahan.\n'
            'Melaksanakan pengurusan peranan dinamik berasaskan senarai supaya '
            'perubahan kakitangan tidak memerlukan pengubahsuaian aliran kerja.',
      },
    ),
    Project(
      id: 'tsight',
      name: 'TSight: Staff Training Management System',
      start: '2023',
      end: '2024',
      techStack: ['Laravel', 'MySQL', 'Bootstrap 5', 'Railway'],
      description: {
        'en': 'Full-stack training enrolment, records and compliance '
            'reporting system actively used by 200+ KPJ staff.\n'
            'Deployed on the Railway cloud platform.',
        'ms': 'Sistem full-stack untuk pendaftaran latihan, rekod dan laporan '
            'pematuhan yang digunakan secara aktif oleh 200+ kakitangan KPJ.\n'
            'Dilancarkan di platform awan Railway.',
      },
    ),
    Project(
      id: 'license',
      name: 'License Tracker (Power App)',
      start: '2025',
      end: '2025',
      techStack: ['Power Apps', 'SharePoint Lists', 'Power Automate'],
      description: {
        'en': 'Internal app tracking software licence expiry with automated '
            'renewal reminders.\n'
            'List-driven: no code changes needed when personnel or licences '
            'change.',
        'ms': 'Aplikasi dalaman untuk menjejak tarikh luput lesen perisian '
            'dengan peringatan pembaharuan automatik.\n'
            'Berasaskan senarai: tiada perubahan kod diperlukan apabila '
            'kakitangan atau lesen berubah.',
      },
    ),
    Project(
      id: 'wasteai',
      name: 'Waste AI Detector',
      start: '2024',
      end: '2024',
      techStack: ['Flutter', 'Firebase', 'HuggingFace ML'],
      description: {
        'en': 'Mobile app classifying waste types via a HuggingFace ML model '
            'with a Firebase real-time backend, supporting hospital '
            'sustainability goals.',
        'ms': 'Aplikasi mudah alih yang mengklasifikasikan jenis sisa '
            'menggunakan model ML HuggingFace dengan backend masa nyata '
            'Firebase, menyokong matlamat kelestarian hospital.',
      },
    ),
    Project(
      id: 'hcsuite',
      name: 'Healthcare Operations Suite (4 Systems)',
      start: '2023',
      end: '2024',
      techStack: ['PHP', 'JavaScript', 'MVC'],
      description: {
        'en': 'Health Screening Booking, Patient Health Screening, Transport '
            'Booking and Event Order systems.\n'
            'Deployed on the hospital intranet.',
        'ms': 'Sistem Tempahan Saringan Kesihatan, Saringan Kesihatan Pesakit, '
            'Tempahan Pengangkutan dan Pesanan Acara.\n'
            'Dilancarkan di intranet hospital.',
      },
    ),
  ],
  certifications: [
    Certification(
      id: 'unity',
      name: 'Unity Certified User',
      issuer: 'Unity',
      year: '2023',
    ),
    Certification(
      id: 'dean',
      name: "Dean's Award (two consecutive semesters)",
      issuer: 'UTHM · CGPA 3.62',
    ),
  ],
  languages: [
    LanguageSkill(
      id: 'ms',
      name: {'en': 'Malay', 'ms': 'Bahasa Melayu'},
      proficiency: {'en': 'Native', 'ms': 'Bahasa ibunda'},
    ),
    LanguageSkill(
      id: 'en',
      name: {'en': 'English', 'ms': 'Bahasa Inggeris'},
      proficiency: {'en': 'Fluent', 'ms': 'Fasih'},
    ),
  ],
);
