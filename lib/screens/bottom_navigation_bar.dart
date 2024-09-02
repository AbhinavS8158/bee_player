
import 'package:bee_player/screens/music/music.dart';
import 'package:bee_player/screens/video/video.dart';

import 'package:flutter/material.dart';




// ignore: camel_case_types
class Bottom_navigation extends StatefulWidget {
  const Bottom_navigation({super.key});

  @override
  State<Bottom_navigation> createState() => _Bottom_navigationState();
}

// ignore: camel_case_types
class _Bottom_navigationState extends State<Bottom_navigation> {

  int _currentselectedIndex =0;

  final pages=[
    const Music(),
    const Watch(),
 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentselectedIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white,
        currentIndex: _currentselectedIndex,
        onTap: (newIndex){
          setState(() {
            _currentselectedIndex=newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "My Music"),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection_rounded), label: "Watch")
        ],
      ),
    );
  }
}
