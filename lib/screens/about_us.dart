import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: () {
    Navigator.pop(context);
  },),
        title: const Text('About Us',style: TextStyle(color: Colors.purple),),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bee Player',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
                Text(
                'Version : 0.0.1',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
            
              Text(
                'Bee Player is a local music and video player that allows users to enjoy their favorite media files stored on their device’s internal storage. The app is designed to offer a seamless and user-friendly experience for playing music and videos offline, without requiring any internet connection or external data sources.',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Features:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- Play music and videos from internal storage\n- Create and manage playlists\n- Shuffle songs and track recent plays\n- Simple and elegant UI for easy navigation',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our goal is to provide a reliable offline music and video player that users can enjoy anytime, anywhere, without requiring any personal data or internet access. Bee Player is focused on offering a high-quality local playback experience without unnecessary features or distractions.',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'For any queries or feedback, feel free to reach out to us through our support channels. We are dedicated to improving Bee Player and making it the best offline media player for your needs.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
