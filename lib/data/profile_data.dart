/// All personal / portfolio content lives here.
/// Edit these values to update the site — no need to touch any UI file.

class ProfileData {
  ProfileData._();

  static const String name = 'Dhanraj Kharat';
  static const String tagline =
      'I build cross-platform apps and web experiences that just work.';
  static const String roles =
      'Flutter Developer  —  Full-Stack Developer  —  Freelancer';

  static const String about =
      'Completed M.Sc. (Computer Applications) at Fergusson College, '
      'Pune (2026). I work across the stack — Flutter for cross-platform '
      'mobile apps, React for the web, and Firebase / SQL / Python on the '
      'backend. I am actively taking on freelance projects and love turning '
      'ideas into fast, functional, good-looking products.';

  static const String email = 'dhanrajkharat9844@gmail.com';
  static const String phone = '+91 8007317574';
  static const String phoneRaw = '918007317574';

  static const String githubUsername = 'dhanraj9844';
  static const String githubUrl = 'https://github.com/dhanraj9844';
  static const String instagramUrl =
      'https://www.instagram.com/dhanraj_kharat9844/?hl=en';
  static const String instagramHandle = '@dhanraj_kharat9844';

  static const List<SkillCategory> skillCategories = [
    SkillCategory('Programming Languages', ['C', 'Java', 'Python']),
    SkillCategory('Web Technologies', [
      'HTML5',
      'CSS3',
      'Sass',
      'Bootstrap',
      'Tailwind CSS',
      'React',
      'Next.js',
      'Angular',
    ]),
    SkillCategory('Mobile Development', [
      'Flutter',
      'Dart',
      'Android',
      'React Native',
      'SwiftUI',
    ]),
    SkillCategory('Databases', [
      'MySQL',
      'PostgreSQL',
      'MongoDB',
      'SQL Server',
      'SQLite',
      'SQL',
    ]),
    SkillCategory('Backend as a Service', [
      'Firebase',
      'Supabase',
      'Firestore',
      'Firebase Auth',
    ]),
    SkillCategory('Version Control', ['Git', 'GitHub', 'GitLab']),
    SkillCategory('APIs & Integration', [
      'Postman',
      'OpenAPI',
      'GraphQL',
      'JSON',
      'XML',
      'Swagger',
    ]),
    SkillCategory('Development Tools', [
      'Android Studio',
      'VS Code',
      'IntelliJ IDEA',
      'Postman',
      'npm',
    ]),
  ];

  static const List<EducationItem> education = [
    EducationItem(
      title: 'M.Sc. Computer Applications',
      place: 'Fergusson College, Pune',
      period: '2026',
      description: 'Completed a Master\'s in Computer Applications, focused on '
          'full-stack development, databases and applied software '
          'engineering.',
    ),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'NEET UG & PG Counseling Platform',
      summary: 'A website and mobile app built for a NEET UG/PG admission '
          'counseling service. Helps students find eligible colleges based '
          'on their rank, and surfaces cutoffs, fees, bonds, required '
          'documents and the full counseling timeline in one place.',
      tags: ['Mobile Application', 'Web', 'Client Project'],
      url: '',
    ),
    ProjectItem(
      title: 'LensXplore',
      summary:
          'A photography booking application designed to connect customers '
          'with photography services. Provides a platform for discovering '
          'photography services and managing photography booking requests.',
      tags: [
        'Photography',
        'Booking Application',
        'Mobile Application',
      ],
      url: 'https://github.com/dhanraj9844/Lensplore-',
    ),
    ProjectItem(
      title: 'Finance Demo',
      summary: 'A cross-platform personal finance tracker built with Flutter '
          'and Firebase, for logging expenses and income with real-time '
          'sync across devices.',
      tags: ['Mobile Application', 'Firebase', 'Cross-platform'],
      url: 'https://github.com/dhanraj9844/Finance-Demo-',
    ),
    ProjectItem(
      title: 'CloudProject',
      summary: 'A cloud-based document management platform developed using '
          'JavaScript. Enables users to upload, store and manage documents '
          'in cloud storage, making files accessible online. Designed to '
          'simplify document handling, centralized storage and secure '
          'access to digital files.',
      tags: ['JavaScript', 'Cloud', 'Web'],
      url: 'https://github.com/dhanraj9844/CloudProject',
    ),
    ProjectItem(
      title: 'Orchid Makeup Studio',
      summary: 'A luxury-inspired website for a makeup studio, salon, spa and '
          'academy. Features service showcases, bridal makeup offerings, '
          'academy information and client enquiry functionality with a '
          'modern responsive interface.',
      tags: [
        'React.js',
        'JavaScript',
        'Tailwind CSS',
        'Framer Motion',
        'Client Project',
      ],
      url: 'https://github.com/dhanraj9844/Orchid_Makeup_Studio',
    ),
    ProjectItem(
      title: 'KPGC Ventures Pvt. Ltd.',
      summary: 'A professional real estate and construction company website '
          'built using Flutter Web. Showcases company information, '
          'property projects and real estate offerings through a modern '
          'responsive web experience.',
      tags: [
        'Flutter',
        'Dart',
        'Flutter Web',
        'Real Estate',
        'Client Project',
      ],
      url: 'https://dhanraj9844.github.io/KPGC/',
    ),
  ];

  static const String availability = 'Available for freelance projects';
}

class EducationItem {
  final String title;
  final String place;
  final String period;
  final String description;

  const EducationItem({
    required this.title,
    required this.place,
    required this.period,
    required this.description,
  });
}

class ProjectItem {
  final String title;
  final String summary;
  final List<String> tags;
  final String url;

  const ProjectItem({
    required this.title,
    required this.summary,
    required this.tags,
    required this.url,
  });
}

class SkillCategory {
  final String title;
  final List<String> skills;
  const SkillCategory(this.title, this.skills);
}
