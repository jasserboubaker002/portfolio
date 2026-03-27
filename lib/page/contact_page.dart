import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          // Titre
          const Text(
            'Me Contacter',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'N\'hésitez pas à me contacter pour toute opportunité',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 50),

          // Contenu principal
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildContactInfo(),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _buildContactForm(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildContactInfo(),
                    const SizedBox(height: 40),
                    _buildContactForm(context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Section des informations de contact
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coordonnées',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        
        // Email
        _buildContactItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'jasserjasser107@gmail.com',
          onTap: () => _launchUrl('mailto:jasserjasser107@gmail.com'),
        ),
        
        const SizedBox(height: 20),
        
        // Téléphone
        _buildContactItem(
          icon: Icons.phone_outlined,
          title: 'Téléphone',
          value: '+216 29 045 002',
          onTap: () => _launchUrl('tel:+21629045002'),
        ),
        
        const SizedBox(height: 20),
        
        // Localisation
        _buildContactItem(
          icon: Icons.location_on_outlined,
          title: 'Localisation',
          value: 'Tunis, Tunisie',
          onTap: null,
        ),
        
        const SizedBox(height: 40),
        
        // Réseaux sociaux
        const Text(
          'Réseaux sociaux',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        
        // GitHub
        _buildSocialMediaItem(
          icon: Icons.code,
          label: 'GitHub',
          username: '@jasserboubaker',
          color: Colors.black,
          url: 'https://github.com/jasserboubaker002',
        ),
        
        const SizedBox(height: 15),
        
        // LinkedIn
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

  // Widget pour chaque contact
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
            child: Icon(
              icon,
              color: Colors.blue.shade700,
              size: 24,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
        ],
      ),
    );
  }

  // Widget pour les réseaux sociaux
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
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  // Formulaire de contact
  Widget _buildContactForm(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Envoyez-moi un message',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Je vous répondrai dans les plus brefs délais',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 30),

          // Champ Nom
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nom complet',
              hintText: 'Votre nom',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Champ Email
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'votre@email.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Champ Message
          TextField(
            controller: messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              hintText: 'Votre message...',
              prefixIcon: const Icon(Icons.message_outlined),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Bouton Envoyer
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _sendEmail(
                  name: nameController.text,
                  email: emailController.text,
                  message: messageController.text,
                  context: context,
                );
                nameController.dispose();
                emailController.dispose();
                messageController.dispose();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Envoyer le message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour ouvrir les URLs
  // Fonction pour envoyer l'email via mailto
  Future<void> _sendEmail({
    required String name,
    required String email,
    required String message,
    required BuildContext context,
  }) async {
    final messenger = ScaffoldMessenger.of(context);

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un email valide'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      // Créer le corps du message
      final subject = 'Portfolio - Message de $name';
      final body = 'Nom: $name\nEmail: $email\n\nMessage:\n$message';
      
      // Construire l'URL mailto pré-remplie
      final mailtoUrl = Uri(
        scheme: 'mailto',
        path: 'xqegajob@formspree.io',
        queryParameters: {
          'subject': subject,
          'body': body,
        },
      );

      await _launchUrl(mailtoUrl.toString());
      
      messenger.showSnackBar(
        const SnackBar(
          content: Text('✅ Votre client email s\'est ouvert. Vérifiez et envoyez le message.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'ouverture du client email.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Fonction pour ouvrir les URLs (réseaux sociaux, email direct, etc.)
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossible d\'ouvrir $url');
    }
  }

}