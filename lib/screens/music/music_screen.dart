import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/widgets/audio_file.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

class MusicScreen extends StatefulWidget {
  final int index;
  final List<SongHive> songs;

  const MusicScreen({super.key, required this.songs, required this.index});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
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
      _updateLastPlayed(currentSong); // Update last played when the screen is opened
    });
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    super.dispose();
  }


  void _updateLastPlayed(SongHive song) async {
    song.lastPlayed = DateTime.now(); // Set the current time as last played
    await song.save(); // Save the updated song to Hive
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
          AudioFile(
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
