import 'package:flutter/material.dart';
import 'about_page.dart';
import 'projects_page.dart';
import 'experience_page.dart';
import 'contact_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 500,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1e1e2f), Color(0xFF2d2d44)],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Jasser Boubaker',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Développeur Flutter | UI/UX Design | Backend Django',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.code,
                          label: 'GitHub',
                          url: 'https://github.com/jasserboubaker002',
                        ),
                        const SizedBox(width: 20),
                        _buildSocialButton(
                          icon: Icons.work,
                          label: 'LinkedIn',
                          url: 'https://www.linkedin.com/in/jasser-boubaker-42548b213/',
                        ),
                        const SizedBox(width: 20),
                        _buildSocialButton(
                          icon: Icons.email,
                          label: 'Contact',
                          url: 'mailto:jasserjasser107@gmail.com',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // À propos
            const AboutPage(),
            
            // Projets
            const ProjectsSection(),
            
            // Expériences
            const ExperienceSection(),
            
            // Contact
            const ContactPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String label, required String url}) {
    return ElevatedButton.icon(
      onPressed: () {
        // Ouvrir URL
      },
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}