import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/audiofileshuffle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

// ignore: camel_case_types
class MusicScreen_shuffle extends StatefulWidget {
  final int index;
  final List<SongHive> songs;

  const MusicScreen_shuffle({super.key, required this.songs, required this.index});

  @override
  State<MusicScreen_shuffle> createState() => _MusicScreen_shuffleState();
}

// ignore: camel_case_types
class _MusicScreen_shuffleState extends State<MusicScreen_shuffle> {
  late AudioPlayer advancedPlayer;
  late SongHive currentSong;
  late Box<SongHive> songBox;

  @override
  void initState() {
    super.initState();
    currentSong = widget.songs[widget.index];
    advancedPlayer = AudioPlayer();

    Hive.openBox<SongHive>('songs').then((box) {
      songBox = box;
      _updateLastPlayed(currentSong); 
    });
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    super.dispose();
  }


  void _updateLastPlayed(SongHive song) async {
    song.lastPlayed = DateTime.now(); 
    await song.save(); 
  }

  void _toggleFavorite(SongHive song) async {
    setState(() {
      currentSong.isFavorite = !currentSong.isFavorite;
      updateFav(currentSong);
    });
    await currentSong.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                currentSong.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: currentSong.isFavorite ? Colors.purple : Colors.white,
              ),
              onPressed: () => _toggleFavorite(currentSong),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 150,
            child: Image.network(
              "https://www.musicscreen.co.uk/index_files/stacks-image-df211a1-800x800.jpg",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              currentSong.title,
               style: GoogleFonts.eduVicWaNtBeginner(
      color: Colors.purple,
      fontSize: 20,
    ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          AudioFileShuffle(
            song: currentSong.path,
            allSongs: widget.songs,
            currentIndex: widget.index,
            onSongChanged: (int value) {
              setState(() {
                currentSong = widget.songs[value];
                _updateLastPlayed(currentSong); // Update last played when the song changes
              });
            },
          ),
        ],
      ),
    );
  }
}
