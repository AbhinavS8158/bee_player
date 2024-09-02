import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
  icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
  onPressed: () {
    Navigator.pop(context);
  },
)
,
        title: const Text('Privacy Policy', style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last updated: [20-08-2024]', 
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Introduction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We value your privacy and are committed to protecting your media files. '
              'This Privacy Policy explains what media-related information we collect from your device, how we use it, and your rights regarding it.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We may collect the following types of media-related information from your device:',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            BulletPoint(text: 'Media Files: Information about the media files on your device (e.g., songs, videos).'),
            BulletPoint(text: 'Media Metadata: Metadata associated with your media files (e.g., file name, size, duration).'),
            SizedBox(height: 16),
            Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We use the media-related information we collect to:',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            BulletPoint(text: 'Provide and improve your media experience within the app.'),
            BulletPoint(text: 'Display and manage your media files and their metadata.'),
            SizedBox(height: 16),
            Text(
              'Sharing Your Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We do not share your media-related information with third parties except as necessary to provide the services described in this policy.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Your Rights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You have the right to:',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            BulletPoint(text: 'Access the media files and metadata we have collected.'),
            BulletPoint(text: 'Request the deletion of your media files and associated metadata.'),
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
              'If you have any questions or concerns about this Privacy Policy, please contact us at [Insert Contact Information].',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(color: Colors.purple),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
