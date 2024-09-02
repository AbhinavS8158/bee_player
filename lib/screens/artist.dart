// import 'package:bee_player/screens/Widgets/artistlist.dart';
// import 'package:bee_player/screens/Widgets/music_category.dart';
// import 'package:bee_player/screens/Widgets/shuffle_song.dart';
// import 'package:bee_player/screens/bottomNavigationBar.dart';

// import 'package:bee_player/screens/favourite.dart';
// import 'package:bee_player/screens/platlist.dart';
// import 'package:bee_player/screens/recent.dart';
// import 'package:flutter/material.dart';

// class Artist extends StatefulWidget {
//   const Artist({super.key});

//   @override
//   State<Artist> createState() => _ArtistState();
// }

// class _ArtistState extends State<Artist> {
//   String selectedButton = 'Artist';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     // topitemtile(),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           buildMusicTile(
//                             color: const Color.fromARGB(255, 109, 32, 93),
//                             icon: Icons.star,
//                             label: 'Favorite',
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const FavouriteScreen()),
//                               );
//                             },
//                           ),
//                           buildMusicTile(
//                             color: const Color.fromARGB(255, 2, 79, 50),
//                             icon: Icons.music_note,
//                             label: 'Playlist',
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const PlaylistScreen()),
//                               );
//                             },
//                           ),
//                           buildMusicTile(
//                             color: const Color.fromARGB(255, 108, 96, 6),
//                             icon: Icons.timelapse,
//                             label: 'Recent',
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const RecentScreen()),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               selectedButton = 'Songs';
//                             });
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const BottomNavigation()),
//                             );
//                           },
//                           child: const Text(
//                             "Songs",
//                             style: TextStyle(
//                               color:  Colors.white,
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               selectedButton = 'Artist';
//                             });
//                           },
//                           child: const Text(
//                             "Artist",
//                             style: TextStyle(
//                               color: Colors.purple
                                
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     shuffle_song(),
//                     SizedBox(
//                       height: 560, // Set the height as per your requirement
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: const ScrollPhysics(),
//                         itemCount: 10,
//                         itemBuilder: (context, index) {
//                           return artist_list();
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             // Align(
//             //   alignment: Alignment.bottomCenter,
//             //   child: bottomMusic(context),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

