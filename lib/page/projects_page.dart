import 'package:flutter/material.dart';
import '../widgets/projects_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Mes Projets',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Center(
                  child: SizedBox(
                    width: 280,
                    child: ProjectCard(
                      title: 'Application de demande d\'achat',
                      description: 'Application full-stack de gestion des demandes d\'achat avec workflow de validation multi-niveaux.',
                      technologies: ['Flutter', 'Django', 'PostgreSQL', 'Figma'],
                      imagePath: 'assets/images/projects/app_achat.png',
                      githubFrontend: 'https://github.com/tonpseudo/app-achat-frontend',
                      githubBackend: 'https://github.com/tonpseudo/app-achat-backend',
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  width: double.infinity,
                  child: ProjectCard(
                    title: 'Application de demande d\'achat',
                    description: 'Application full-stack de gestion des demandes d\'achat avec workflow de validation multi-niveaux.',
                    technologies: ['Flutter', 'Django', 'PostgreSQL', 'Figma'],
                    imagePath: 'assets/images/projects/app_achat.png',
                    githubFrontend: 'https://github.com/tonpseudo/app-achat-frontend',
                    githubBackend: 'https://github.com/tonpseudo/app-achat-backend',
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}