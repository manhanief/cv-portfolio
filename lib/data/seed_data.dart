import 'models/cv_data.dart';

/// Initial CV content. Written to Firestore on the first admin login;
/// after that, edit everything inline on the page.
const seedCv = CvData(
  profile: Profile(
    name: 'Esman Hanief',
    title: {
      'en': 'IT Executive · IT Support & Infrastructure · System Developer',
      'ms': 'Eksekutif IT · Sokongan & Infrastruktur IT · Pembangun Sistem',
    },
    summary: {
      'en': 'IT Executive at KPJ Rawang Specialist Hospital covering both '
          'sides of hospital IT: keeping day-to-day operations running '
          'through IT service management, asset management, LAN/WAN and '
          'infrastructure support and IT reporting, and building the internal '
          'web systems, Microsoft 365 automation and AI-powered mobile apps '
          'used by 200+ staff. Completing a Bachelor of Computer Science at '
          'UiTM part-time alongside full-time work.',
      'ms': 'Eksekutif IT di KPJ Rawang Specialist Hospital yang merangkumi '
          'kedua-dua aspek IT hospital: memastikan operasi harian berjalan '
          'lancar melalui pengurusan perkhidmatan IT, pengurusan aset, '
          'sokongan LAN/WAN dan infrastruktur serta laporan IT, di samping '
          'membina sistem web dalaman, automasi Microsoft 365 dan aplikasi '
          'mudah alih berkuasa AI yang digunakan oleh 200+ kakitangan. Sedang '
          'melengkapkan Ijazah Sarjana Muda Sains Komputer di UiTM secara '
          'separuh masa sambil bekerja sepenuh masa.',
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
        'en': 'IT Executive (IT Support & System Development)',
        'ms': 'Eksekutif IT (Sokongan IT & Pembangunan Sistem)',
      },
      company: 'KPJ Rawang Specialist Hospital',
      location: 'Rawang, Selangor',
      start: '2023',
      description: {
        'en': 'IT Service Management (ITSM): provided first- and second-line '
            'support for hospital staff, handling incidents and service '
            'requests end to end (logging, prioritisation, troubleshooting, '
            'escalation to vendors and closure) in a regulated healthcare '
            'environment.\n'
            'IT Asset Management (ITAM): maintained the hardware and software '
            'asset inventory across the lifecycle (deployment, transfer and '
            'disposal) and tracked software licences and renewals, later '
            'automated with a License Tracker Power App.\n'
            'Infrastructure & networking: managed the hospital LAN/intranet '
            'and supported WAN connectivity, network devices, end-user '
            'computers, printers and peripherals, coordinating with vendors '
            'and service providers on faults.\n'
            'User & access administration: managed Microsoft 365 and Entra ID '
            'accounts and access for onboarding, offboarding and day-to-day '
            'requests.\n'
            'IT reporting & documentation: prepared IT reports on support '
            'activity, asset status and licence renewals for IT management, '
            'and wrote technical documentation and user guides.\n'
            'System development: architected and deployed 8+ internal web '
            'systems (staff training, health screening, transport booking, '
            'event management) serving 200+ hospital staff daily, plus the '
            'Waste AI Detector mobile app (Flutter + Firebase + HuggingFace '
            'ML).\n'
            'Process re-engineering: moved the charge code approval process '
            'from a legacy Excel/VBA workflow to a cloud-based multi-level '
            'system (Power Automate, SharePoint Online, Excel Online, '
            'Teams/Outlook, Entra ID) at zero additional cost under existing '
            'M365 E3 licensing.\n'
            'Security: eliminated identity spoofing and hardcoded credentials '
            'by moving approver authentication to Entra ID verified sign-in, '
            'with sequential HOS → Finance → CEO → IT routing, urgent-handling '
            'logic and an append-only audit trail.',
        'ms': 'Pengurusan Perkhidmatan IT (ITSM): menyediakan sokongan '
            'barisan pertama dan kedua kepada kakitangan hospital, '
            'mengendalikan insiden dan permintaan perkhidmatan dari awal '
            'hingga akhir (pendaftaran, keutamaan, penyelesaian masalah, '
            'eskalasi kepada vendor dan penutupan) dalam persekitaran '
            'penjagaan kesihatan yang dikawal selia.\n'
            'Pengurusan Aset IT (ITAM): menyelenggara inventori aset '
            'perkakasan dan perisian sepanjang kitar hayat (pemasangan, '
            'pemindahan dan pelupusan) serta menjejak lesen perisian dan '
            'pembaharuannya, yang kemudian diautomasikan dengan Power App '
            'License Tracker.\n'
            'Infrastruktur & rangkaian: mengurus LAN/intranet hospital dan '
            'menyokong sambungan WAN, peranti rangkaian, komputer pengguna, '
            'pencetak dan periferal, serta berhubung dengan vendor dan '
            'penyedia perkhidmatan bagi kerosakan.\n'
            'Pentadbiran pengguna & akses: mengurus akaun dan akses Microsoft '
            '365 serta Entra ID bagi kemasukan, keluar dan permintaan '
            'harian.\n'
            'Laporan & dokumentasi IT: menyediakan laporan IT tentang '
            'aktiviti sokongan, status aset dan pembaharuan lesen untuk '
            'pengurusan IT, serta menulis dokumentasi teknikal dan panduan '
            'pengguna.\n'
            'Pembangunan sistem: mereka bentuk dan melancarkan 8+ sistem web '
            'dalaman (latihan kakitangan, saringan kesihatan, tempahan '
            'pengangkutan, pengurusan acara) yang digunakan oleh 200+ '
            'kakitangan hospital setiap hari, serta aplikasi mudah alih Waste '
            'AI Detector (Flutter + Firebase + HuggingFace ML).\n'
            'Kejuruteraan semula proses: memindahkan proses kelulusan kod caj '
            'daripada aliran kerja Excel/VBA lama kepada sistem berbilang '
            'peringkat berasaskan awan (Power Automate, SharePoint Online, '
            'Excel Online, Teams/Outlook, Entra ID) tanpa kos tambahan di '
            'bawah lesen M365 E3 sedia ada.\n'
            'Keselamatan: menghapuskan penyamaran identiti dan kelayakan '
            'berkod keras dengan memindahkan pengesahan pelulus kepada log '
            'masuk Entra ID yang disahkan, dengan penghalaan berurutan HOS → '
            'Kewangan → CEO → IT, logik kes segera dan jejak audit '
            'tambah-sahaja.',
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
      id: 'itsupport',
      category: {
        'en': 'IT Support & Infrastructure',
        'ms': 'Sokongan & Infrastruktur IT',
      },
      items: [
        'ITSM (Incident & Service Requests)',
        'ITAM (Asset & Licence Management)',
        'LAN / WAN',
        'Network Troubleshooting',
        'Hardware & Peripheral Support',
        'M365 / Entra ID Administration',
        'IT Reporting',
        'Technical Documentation',
      ],
    ),
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
      items: ['Healthcare IT', 'Process Re-engineering'],
    ),
    SkillGroup(
      id: 'soft',
      category: {'en': 'Soft Skills', 'ms': 'Kemahiran Insaniah'},
      items: [
        'Stakeholder Communication',
        'User Support & Training',
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
