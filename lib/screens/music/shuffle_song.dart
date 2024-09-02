import 'dart:math';

import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/musicsreen_shaffle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget shuffleSong(BuildContext context, List<SongHive> songs) {
  final random = Random();

  void shuffleAndPlay() {
    if (songs.isEmpty) return; 
    int randomIndex = random.nextInt(songs.length); 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicScreen_shuffle(index: randomIndex, songs: songs),
      ),
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(
        onPressed: shuffleAndPlay,
        icon: const Icon(
          Icons.play_circle_fill,
          size: 40,
          color: Colors.purple,
        ),
      ),
     TextButton(
  onPressed: shuffleAndPlay,
  child: Text(
    "Shuffle playback",
    style: GoogleFonts.eduVicWaNtBeginner(
      color: Colors.white,
    ),
  ),
),

    ],
  );
}
