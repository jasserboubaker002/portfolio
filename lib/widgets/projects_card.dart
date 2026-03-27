import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final String imagePath;
  final String githubFrontend;
  final String githubBackend;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.technologies,
    required this.imagePath,
    required this.githubFrontend,
    required this.githubBackend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  children: technologies.map((tech) {
                    return Chip(
                      label: Text(tech, style: const TextStyle(fontSize: 12)),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      backgroundColor: Colors.blue.shade50,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (githubFrontend.isNotEmpty)
                      _buildProjectButton(
                        icon: Icons.code,
                        label: 'Frontend',
                        url: githubFrontend,
                      ),
                    const SizedBox(width: 8),
                    if (githubBackend.isNotEmpty)
                      _buildProjectButton(
                        icon: Icons.storage,
                        label: 'Backend',
                        url: githubBackend,
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

  Widget _buildProjectButton({required IconData icon, required String label, required String url}) {
    return OutlinedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: Icon(icon, size: 16),
      label: Text(label),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossible d\'ouvrir $url');
    }
  }
}