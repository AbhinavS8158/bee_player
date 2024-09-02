
import 'package:bee_player/screens/music/platlist.dart';
import 'package:bee_player/screens/splash.dart';
import 'package:bee_player/screens/video/video.dart';
import 'package:bee_player/screens/video/videoplaylist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/model/db_modal.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongHiveAdapter());
  Hive.registerAdapter(VideoHiveAdapter());
  Hive.registerAdapter(PlaylistAdapter());
  Hive.registerAdapter(VideoplaylistAdapter());


  await Hive.openBox<SongHive>('songs');
  await Hive.openBox<VideoHive>('videos');
  await Hive.openBox<Playlist>('playlists');
  await Hive.openBox<Videoplaylist>('video_playlist');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: '/',
  routes: {
  
    '/playlist': (context) => const PlaylistScreen(),
    '/VideoPlaylistScreen':((context) => const VideoPlaylistScreen()),
    '/watch':(context) => const Watch(),
    
   

  },
      debugShowCheckedModeBanner: false,
      title: 'Bee Player',
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
