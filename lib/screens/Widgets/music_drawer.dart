import 'package:bee_player/screens/about_us.dart';
import 'package:bee_player/screens/music/favourite.dart';
import 'package:bee_player/screens/music/platlist.dart';
import 'package:bee_player/screens/music/recent.dart';
import 'package:bee_player/screens/policy.dart';
import 'package:bee_player/screens/termsandconditition.dart';
import 'package:flutter/material.dart';

class MusicDrawer extends StatelessWidget {
  const MusicDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.purple),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.purple),
              title:
                  const Text('Favorite', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouriteScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.music_note, color: Colors.purple),
              title:
                  const Text('Playlist', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlaylistScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.timelapse, color: Colors.purple),
              title:
                  const Text('Recent', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecentlyPlayedWidget(),
                  ),
                );
              },
            ),
            const SizedBox(height: 200),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.purple),
              title: const Text('Privacy Policy',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user, color: Colors.purple),
              title: const Text('Terms and Conditions',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.purple),
              title: const Text(
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
