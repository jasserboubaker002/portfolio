import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jasser Boubaker - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF0066CC),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0066CC),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black87),
          displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87, height: 1.6),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}

// ==================== PAGE D'ACCUEIL AVEC NAVIGATION ====================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  String _activeSection = 'accueil';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveSection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _updateActiveSection() {
    final offset = _scrollController.offset;
    final aboutOffset = _sectionOffset(_aboutKey);
    final projectsOffset = _sectionOffset(_projectsKey);
    final experienceOffset = _sectionOffset(_experienceKey);
    final contactOffset = _sectionOffset(_contactKey);

    String section;
    if (offset < aboutOffset - 120) {
      section = 'accueil';
    } else if (offset < projectsOffset - 120) {
      section = 'about';
    } else if (offset < experienceOffset - 120) {
      section = 'projects';
    } else if (offset < contactOffset - 120) {
      section = 'experience';
    } else {
      section = 'contact';
    }

    if (section != _activeSection) {
      setState(() {
        _activeSection = section;
      });
    }
  }

  double _sectionOffset(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return double.infinity;
    final box = context.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero, ancestor: context.findRenderObject())
        .dy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Barre de navigation
            _buildNavBar(),
            
            // Hero Section
            _buildHeroSection(),
            
            // À propos
            Container(
              key: _aboutKey,
              child: _buildAboutSection(),
            ),
            
            // Projets
            Container(
              key: _projectsKey,
              child: _buildProjectsSection(),
            ),
            
            // Expériences
            Container(
              key: _experienceKey,
              child: _buildExperienceSection(),
            ),
            
            // Contact
            Container(
              key: _contactKey,
              child: _buildContactSection(),
            ),
            
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ==================== BARRE DE NAVIGATION ====================
  
  Widget _buildNavBar() {
    return Material(
      elevation: 2,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo / Nom avec style
            GestureDetector(
              onTap: () => Scrollable.ensureVisible(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0066CC), Color(0xFF0052A3)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'JB',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            
            // Menu desktop
            if (MediaQuery.of(context).size.width > 600)
              Row(
                children: [
                  _buildNavItem('Accueil', () => _scrollToSection(_heroKey), _activeSection == 'accueil'),
                  const SizedBox(width: 24),
                  _buildNavItem('À propos', () => _scrollToSection(_aboutKey), _activeSection == 'about'),
                  const SizedBox(width: 24),
                  _buildNavItem('Projets', () => _scrollToSection(_projectsKey), _activeSection == 'projects'),
                  const SizedBox(width: 24),
                  _buildNavItem('Expériences', () => _scrollToSection(_experienceKey), _activeSection == 'experience'),
                  const SizedBox(width: 24),
                  _buildNavItem('Contact', () => _scrollToSection(_contactKey), _activeSection == 'contact'),
                ],
              ),
          
          // Menu mobile (burger)
          if (MediaQuery.of(context).size.width <= 600)
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu_rounded, size: 28),
              onSelected: (value) {
                switch (value) {
                  case 'accueil':
                    Scrollable.ensureVisible(context);
                    break;
                  case 'about':
                    _scrollToSection(_aboutKey);
                    break;
                  case 'projects':
                    _scrollToSection(_projectsKey);
                    break;
                  case 'experience':
                    _scrollToSection(_experienceKey);
                    break;
                  case 'contact':
                    _scrollToSection(_contactKey);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'accueil', child: Text('Accueil')),
                const PopupMenuItem(value: 'about', child: Text('À propos')),
                const PopupMenuItem(value: 'projects', child: Text('Projets')),
                const PopupMenuItem(value: 'experience', child: Text('Expériences')),
                const PopupMenuItem(value: 'contact', child: Text('Contact')),
              ],
            ),
        ],
      ),
    ),
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap, bool isActive) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isActive ? Colors.blue.shade50 : Colors.transparent,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? Colors.blue.shade700 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== HERO SECTION ====================

  Widget _buildHeroSection() {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0066CC),
            const Color(0xFF0052A3),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar avec ombre et animation
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_4_rounded,
                    size: 120,
                    color: Colors.blue.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Jasser Boubaker',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: const Text(
                  'Développeur Flutter | UI/UX Design | Backend Django',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    url: 'https://github.com/jasserboubaker002',
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    icon: Icons.work_rounded,
                    label: 'LinkedIn',
                    url: 'https://www.linkedin.com/in/jasser-boubaker-42548b213/',
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    icon: Icons.email_rounded,
                    label: 'Contact',
                    url: 'mailto:jasserjasser107@email.com',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String label, required String url}) {
    return ElevatedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }

  // ==================== À PROPOS ====================

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        children: [
          Text(
            'À propos de moi',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: const Text(
              'Développeur Flutter passionné par le développement mobile multiplateforme, '
              'l\'UI/UX Design avec Figma et l\'intégration backend (APIs REST). '
              'Actuellement en alternance, je cherche une opportunité pour mettre mes compétences '
              'en pratique dans un environnement innovant.',
              style: TextStyle(fontSize: 18, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              _buildSkillChip('Flutter'),
              _buildSkillChip('Dart'),
              _buildSkillChip('Django'),
              _buildSkillChip('Python'),
              _buildSkillChip('Figma'),
              _buildSkillChip('REST API'),
              _buildSkillChip('PostgreSQL'),
              _buildSkillChip('Git'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Colors.blue.shade50,
      side: BorderSide.none,
    );
  }

  // ==================== PROJETS ====================

  Widget _buildProjectsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            'Mes Projets',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Découvrez mes réalisations récentes',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return _buildProjectCard();
                  },
                );
              } else {
                return _buildProjectCard();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard() {
    return Card(
      elevation: 2,
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Icon(
                Icons.shopping_cart,
                size: 60,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Application de demande d\'achat',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Application full-stack de gestion des demandes d\'achat avec workflow de validation multi-niveaux.',
                  style: TextStyle(height: 1.4),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildTechChip('Flutter'),
                    _buildTechChip('Django'),
                    _buildTechChip('PostgreSQL'),
                    _buildTechChip('Figma'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildProjectButton(
                      icon: Icons.code,
                      label: 'GitHub',
                      url: 'https://github.com/tonpseudo',
                    ),
                    const SizedBox(width: 12),
                    _buildProjectButton(
                      icon: Icons.open_in_new,
                      label: 'Démo',
                      url: 'https://tonprojet.com',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Chip(
      label: Text(tech, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.blue.shade50,
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildProjectButton({required IconData icon, required String label, required String url}) {
    return OutlinedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ==================== EXPÉRIENCES ====================

  Widget _buildExperienceSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        children: [
          Text(
            'Expériences Professionnelles',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Mon parcours et mes réalisations',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 50),
          _buildExperienceCard(
            title: 'Développeur Flutter / Full-Stack',
            company: 'TechMind Solutions',
            period: 'Mai 2025 - Aujourd\'hui',
            tasks: [
              'Conception et développement d\'une application complète de demande d\'achat',
              'Design UI/UX sur Figma : maquettes interactives, validation des parcours utilisateurs',
              'Développement frontend Flutter avec architecture modulaire et gestion d\'état Provider',
              'Backend Django REST Framework avec authentification JWT et gestion des rôles',
              'Modélisation base de données PostgreSQL',
            ],
          ),
          const SizedBox(height: 25),
          _buildExperienceCard(
            title: 'Concepteur-Dessinateur FTTH',
            company: 'HTA Consulting',
            period: 'Juillet 2023 - Mai 2025',
            tasks: [
              'Conception de plans FTTH pour le marché canadien (structures aériennes et souterraines)',
              'Calcul de charge des poteaux avec Caoft selon les normes France Télécom / Orange',
              'Analyse de données LiDAR pour optimiser le tracé des réseaux',
              'Création de blocs dynamiques sous AutoCAD',
              'Élaboration d\'une checklist de validation systématique',
            ],
          ),
          const SizedBox(height: 25),
          _buildExperienceCard(
            title: 'Chargé d\'étude FTTH',
            company: 'Intercom Technologies (Stage)',
            period: 'Février 2022 - Juin 2022',
            tasks: [
              'Maîtrise des logiciels : COMAC, QGIS, CAP-FT',
              'Calcul de charge des poteaux avec Caoft',
              'Développement d\'un algorithme Deep Learning avec Python',
              'Intégration de l\'algorithme dans QGIS via PyQGIS',
            ],
          ),
          const SizedBox(height: 25),
          _buildExperienceCard(
            title: 'Chargé de systèmes d\'informations',
            company: 'Tunisie Télécom Siliana (Stage)',
            period: 'Août 2019 - Septembre 2020',
            tasks: [
              'Découverte du réseau de transmission régional et des équipements optiques',
              'Gestion et prise en charge des périphériques réseau',
              'Analyse et diagnostic des problèmes de réseau',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard({
    required String title,
    required String company,
    required String period,
    required List<String> tasks,
  }) {
    return Card(
      elevation: 1,
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              company,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            ...tasks.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(fontSize: 16, color: Colors.blue.shade700)),
                  Expanded(child: Text(task)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  // ==================== CONTACT ====================

  Widget _buildContactSection() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            'Me Contacter',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'N\'hésitez pas à me contacter pour toute opportunité',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo()),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _buildContactForm(
                        nameController: nameController,
                        emailController: emailController,
                        messageController: messageController,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildContactInfo(),
                    const SizedBox(height: 40),
                    _buildContactForm(
                      nameController: nameController,
                      emailController: emailController,
                      messageController: messageController,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coordonnées',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        _buildContactItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'jasser.boubaker@email.com',
          onTap: () => _launchUrl('mailto:jasser.boubaker@email.com'),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          icon: Icons.phone_outlined,
          title: 'Téléphone',
          value: '+216 290 450 02',
          onTap: () => _launchUrl('tel:+216 290 450 02'),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          icon: Icons.location_on_outlined,
          title: 'Localisation',
          value: 'Tunis, Tunisie',
          onTap: null,
        ),
        const SizedBox(height: 40),
        const Text(
          'Réseaux sociaux',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildSocialMediaItem(
          icon: Icons.code,
          label: 'GitHub',
          username: '@jasserboubaker',
          color: Colors.black,
          url: 'https://github.com/jasserboubaker002',
        ),
        const SizedBox(height: 15),
        _buildSocialMediaItem(
          icon: Icons.work,
          label: 'LinkedIn',
          username: 'Jasser Boubaker',
          color: Colors.blue.shade700,
          url: 'https://www.linkedin.com/in/jasser-boubaker-42548b213/',
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue.shade700, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          if (onTap != null)
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildSocialMediaItem({
    required IconData icon,
    required String label,
    required String username,
    required Color color,
    required String url,
  }) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  Text(username, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Icon(Icons.open_in_new, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController messageController,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Envoyez-moi un message',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Je vous répondrai dans les plus brefs délais',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nom complet',
              hintText: 'Votre nom',
              prefixIcon: Icon(Icons.person_outline, color: Colors.blue.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              filled: true,
              fillColor: Colors.blue.shade50,
            ),
          ),
          const SizedBox(height: 22),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'votre@email.com',
              prefixIcon: Icon(Icons.email_outlined, color: Colors.blue.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              filled: true,
              fillColor: Colors.blue.shade50,
            ),
          ),
          const SizedBox(height: 22),
          TextField(
            controller: messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              hintText: 'Votre message...',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Icon(Icons.message_outlined, color: Colors.blue.shade600),
              ),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              filled: true,
              fillColor: Colors.blue.shade50,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                _sendEmail(
                  name: nameController.text,
                  email: emailController.text,
                  message: messageController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Envoyer le message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== FOOTER ====================

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Colors.grey.shade900,
      child: const Center(
        child: Text(
          '© 2025 Jasser Boubaker - Tous droits réservés',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  // ==================== FONCTIONS UTILITAIRES ====================

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossible d\'ouvrir $url');
    }
  }

  void _sendEmail({
    required String name,
    required String email,
    required String message,
  }) {
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs', Colors.red);
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showSnackBar('Veuillez entrer un email valide', Colors.red);
      return;
    }

    final subject = 'Portfolio - Message de $name';
    final body = '''
Nom : $name
Email : $email

Message :
$message
''';

    final emailUri = Uri.parse(
      'mailto:jasser.boubaker@email.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    _launchUrl(emailUri.toString());
    _showSnackBar('Message envoyé avec succès !', Colors.green);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}