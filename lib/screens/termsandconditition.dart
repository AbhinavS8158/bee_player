import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: () {
    Navigator.pop(context);
  },
),
        title: const Text('Terms and Conditions',
         style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Terms and Conditions',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.purple,
            //   ),
            // ),
            // SizedBox(height: 16),
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
              'Welcome to Bee Player! These Terms and Conditions outline the rules and regulations for using our local music and video player application. By using Bee Player, you agree to comply with these terms.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '1. Application Use',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bee Player is designed to play audio and video files that are stored on your device’s internal storage. The app does not support streaming or accessing files from external sources or cloud storage.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '2. Media Files Access',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The application accesses media files on your internal storage solely for the purpose of playing and managing your local media. We do not store, transmit, or access any media files beyond your device’s internal storage.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '3. User Responsibilities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Users are responsible for ensuring that the media files they access and manage using Bee Player are legally obtained and that they have the right to use these files. Bee Player is not liable for any issues related to copyright or intellectual property violations.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '4. Privacy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We value your privacy. Bee Player only collects information necessary for the app’s functionality and does not collect personal information such as your name or email address. For more details, please refer to our Privacy Policy.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '5. Changes to Terms',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We reserve the right to update or modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting to this page. Your continued use of Bee Player constitutes your acceptance of the updated terms.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '6. Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions or concerns about these Terms and Conditions, please contact us at abhinav.s8158@gmail.com',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
