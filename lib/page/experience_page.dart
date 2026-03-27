import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          const Text(
            'Expériences Professionnelles',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          _buildExperienceCard(
            title: 'Développeur Flutter / Full-Stack',
            company: 'TechMind Solutions',
            period: 'Mai 2025 - Aujourd\'hui',
            tasks: [
              'Conception et développement d\'une application de demande d\'achat',
              'Design UI/UX avec Figma',
              'Backend Django avec authentification JWT',
              'Gestion des rôles et workflow de validation',
            ],
          ),
          const SizedBox(height: 20),
          _buildExperienceCard(
            title: 'Concepteur-Dessinateur FTTH',
            company: 'HTA Consulting',
            period: 'Juillet 2023 - Mai 2025',
            tasks: [
              'Conception de plans FTTH pour le marché canadien',
              'Calcul de charge des poteaux avec Caoft',
              'Analyse de données LiDAR et optimisation des tracés',
              'Création de blocs dynamiques sous AutoCAD',
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
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              company,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 15),
            ...tasks.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(task)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}