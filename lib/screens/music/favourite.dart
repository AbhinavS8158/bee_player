import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/music_screen.dart';
import 'package:bee_player/screens/music/shuffle_song.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late List<SongHive> favoriteSongs = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteSongs();
  }

  Future<void> _loadFavoriteSongs() async {
    final List<SongHive> fetchedSongs = await getFavoriteSongs();
    setState(() {
      favoriteSongs = fetchedSongs;
    });
  }

  Future<void> _removeFavoriteSong(SongHive song) async {
    await removeFromFavorites(song);
    setState(() {
      favoriteSongs.remove(song);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title:  Text(
          "F a v o u r i t e",
          style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white70,
          )
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                shuffleSong(context, favoriteSongs),
              ],
            ),
            favoriteSongs.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'No items',
                      style: TextStyle(color: Colors.purple),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favoriteSongs.length,
                    itemBuilder: (context, index) {
                      final song = favoriteSongs[index];
                      return ListTile(
                        title: Text(
                          song.title,
                          style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          song.artist,
                          style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicScreen(
                                songs: favoriteSongs,
                                index: index,
                              ),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.purple),
                          onPressed: () {
                            _removeFavoriteSong(song);
                          },
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
