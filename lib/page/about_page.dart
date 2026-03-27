import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        children: [
          // Titre
          const Text(
            'À propos de moi',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          
          // Sous-titre
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Découvrez qui je suis et ce que je fais',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Contenu principal
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildBioSection(),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 2,
                      child: _buildSkillsSection(),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildBioSection(),
                    const SizedBox(height: 50),
                    _buildSkillsSection(),
                  ],
                );
              }
            },
          ),
          
          const SizedBox(height: 60),
          
          // Centres d'intérêt
          _buildInterestsSection(),
        ],
      ),
    );
  }

  // ==================== BIOGRAPHIE ====================
  
  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Qui suis-je ?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                '👋 Bonjour ! Je suis Jasser Boubaker',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Développeur Flutter passionné par le développement mobile multiplateforme, '
                'l\'UI/UX Design avec Figma et l\'intégration backend (APIs REST). '
                'Actuellement en alternance, je cherche une opportunité pour mettre mes compétences '
                'en pratique dans un environnement innovant.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'J\'aime créer des applications modernes, performantes et agréables à utiliser. '
                'Mon approche combine un design soigné avec un code propre et maintenable.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Parcours
        const Text(
          'Mon parcours',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildTimelineItem(
          year: '2022 - 2026',
          title: 'Cycle ingénieur en informatique',
          description: 'L\'École Supérieure privée des Sciences Appliquées et de Management SESAME',
          icon: Icons.school,
        ),
        
        const SizedBox(height: 20),
        
        _buildTimelineItem(
          year: '2019 - 2022',
          title: 'Licence en Technologies de l\'information et de communication',
          description: 'Institut supérieur des sciences appliquées et de la technologie Mateur',
          icon: Icons.school,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String year,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blue.shade700, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                year,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== COMPÉTENCES ====================
  
  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compétences techniques',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        
        // Langages
        _buildSkillCategory(
          title: 'Langages',
          skills: ['Dart', 'Python', 'JavaScript', 'SQL', 'HTML/CSS'],
        ),
        
        const SizedBox(height: 25),
        
        // Frameworks
        _buildSkillCategory(
          title: 'Frameworks & Outils',
          skills: ['Flutter', 'Django', 'Provider', 'BLoC', 'Django REST Framework'],
        ),
        
        const SizedBox(height: 25),
        
        // Design
        _buildSkillCategory(
          title: 'Design',
          skills: ['Figma', 'UI/UX Design', 'Prototypage'],
        ),
        
        const SizedBox(height: 25),
        
        // Bases de données
        _buildSkillCategory(
          title: 'Bases de données',
          skills: ['PostgreSQL', 'SQLite'],
        ),
        
        const SizedBox(height: 25),
        
        // Outils
        _buildSkillCategory(
          title: 'Outils & Méthodologies',
          skills: ['Git', 'GitHub', 'REST API', 'PyQGIS', 'Agile/Scrum'],
        ),
        
        const SizedBox(height: 25),
        
        // Télécoms (compétences métier)
        _buildSkillCategory(
          title: 'Télécoms & SIG',
          skills: ['AutoCAD', 'QGIS', 'CAP-FT', 'Caoft', 'LiDAR'],
        ),
      ],
    );
  }

  Widget _buildSkillCategory({
    required String title,
    required List<String> skills,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ==================== CENTRES D'INTÉRÊT ====================
  
  Widget _buildInterestsSection() {
    return Column(
      children: [
        const Text(
          'Centres d\'intérêt',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Ce qui me motive au quotidien',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 40),
        
        Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: [
            _buildInterestCard(
              icon: Icons.code,
              title: 'Développement',
              description: 'Créer des applications innovantes',
              color: Colors.blue,
            ),
            _buildInterestCard(
              icon: Icons.design_services,
              title: 'UI/UX Design',
              description: 'Designer des interfaces modernes',
              color: Colors.purple,
            ),
            _buildInterestCard(
              icon: Icons.psychology,
              title: 'Tech & IA',
              description: 'Explorer les nouvelles technologies',
              color: Colors.green,
            ),
            _buildInterestCard(
              icon: Icons.map,
              title: 'Géomatique',
              description: 'Analyser des données spatiales',
              color: Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInterestCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 40),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}