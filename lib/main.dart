import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Idzham Profile',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: !isMobile
            ? BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.5,
                  colors: [
                    const Color(0xFF6366F1).withValues(alpha: 0.05), // Updated here
                    Colors.transparent,
                  ],
                ),
              )
            : null,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 40 : 60,
              horizontal: 20,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 32),

                  _buildSectionTitle('Background'),
                  _buildInfoCard(Icons.home_rounded, 'Origin', 'Pasir Mas, Kelantan', null),
                  _buildInfoCard(Icons.school_rounded, 'Current Study', 'Sultan Idris Education University', null),
                  _buildInfoCard(Icons.videogame_asset_rounded, 'Hobby', 'Playing Mobile Games', null),

                  const SizedBox(height: 24),

                  _buildSectionTitle('Academic Achievements'),
                  _buildInfoCard(Icons.history_edu_rounded, 'SPM Result', '6A 3B', null),
                  _buildInfoCard(Icons.grade_rounded, 'Matriculation CGPA', '3.50', null),

                  const SizedBox(height: 24),

                  _buildSectionTitle('Connect with me'),
                  _buildInfoCard(
                    Icons.phone_android_rounded,
                    'Contact',
                    '0109076257',
                    () => _launch('tel:0109076257'),
                  ),
                  _buildInfoCard(
                    Icons.mail_rounded,
                    'Email',
                    'idzhamdanial1609@gmail.com',
                    () => _launch('mailto:idzhamdanial1609@gmail.com'),
                  ),
                  _buildInfoCard(
                    Icons.camera_alt_rounded,
                    'Instagram',
                    '@idzdanial',
                    () => _launch('https://instagram.com/idzdanial'),
                  ),
                  _buildInfoCard(
                    Icons.music_note_rounded,
                    'TikTok',
                    '@ziyusasin',
                    () => _launch('https://tiktok.com/@ziyusasin'),
                  ),

                  const SizedBox(height: 40),
                  _buildQuoteSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFF6366F1),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
            ),
          ),
          child: const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white10,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Idzham Danial',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        const Text(
          '16 Sept 2004 • Creative Developer',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    String value,
    VoidCallback? onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)), // Updated here
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF6366F1), size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.white12,
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02), // Updated here
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      child: const Column(
        children: [
          Icon(Icons.format_quote_rounded, color: Color(0xFF6366F1), size: 32),
          SizedBox(height: 10),
          Text(
            'Keep moving. The speed doesn\'t matter, forward is forward.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}