import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/favourite.dart';
import 'package:bee_player/screens/music/music_list.dart';
import 'package:bee_player/screens/music/platlist.dart';
import 'package:bee_player/screens/music/recent.dart';
import 'package:bee_player/screens/music/shuffle_song.dart';
import 'package:bee_player/screens/widgets/music_category.dart';
import 'package:bee_player/screens/widgets/music_drawer.dart';
import 'package:bee_player/screens/widgets/top_item_tile.dart';
import 'package:flutter/material.dart';


class Music extends StatefulWidget {
  const Music({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  void initState() {
    super.initState();
    getAllSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: topItemTile(),
        backgroundColor: Colors.black,
      ),
      drawer: const MusicDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildMusicTile(
                    color: const Color.fromARGB(255, 109, 32, 93),
                    icon: Icons.star,
                    label: 'Favorite',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouriteScreen(),
                        ),
                      );
                    },
                  ),
                  buildMusicTile(
                    color: const Color.fromARGB(255, 2, 79, 50),
                    icon: Icons.music_note,
                    label: 'Playlist',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaylistScreen(),
                        ),
                      );
                    },
                  ),
                  buildMusicTile(
                    color: const Color.fromARGB(255, 108, 96, 6),
                    icon: Icons.timelapse,
                    label: 'Recent',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecentlyPlayedWidget(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Songs",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder<List<SongHive>>(
                valueListenable: songlistNotifier,
                builder: (context, songs, _) {
                  return Column(
                    children: [
                      shuffleSong(context, songs),
                      songs.isEmpty
                          ? const Center(
                              child: Text(
                                "No Songs",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: songs.length,
                                itemBuilder: (context, index) {
                                  return listTileList(
                                    context,
                                    index,
                                    songs[index],
                                    songs,
                                  );
                                },
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
