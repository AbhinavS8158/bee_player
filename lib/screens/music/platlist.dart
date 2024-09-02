import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/add_playlist.dart';
import 'package:bee_player/screens/music/playlistsongs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _playlistNameController = TextEditingController();
  late Box<Playlist> playlistBox;

  @override
  void initState() {
    super.initState();
    playlistBox = Hive.box<Playlist>('playlists');
  }
  void _showDeleteDialog(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Playlist'),
        content: const Text('Are you sure you want to delete this playlist?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              _deletePlaylist(index); 
              Navigator.of(context).pop(); 
            },
          ),
        ],
      );
    },
  );
}

  void _deletePlaylist(int index) {
    playlistBox.deleteAt(index);
    setState(() {});
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
          "P l a y l i s t",
          style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 500,
                    color: Colors.black.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Playlist name',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _playlistNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Enter playlist name',
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPlaylist(
                                    playlistname: _playlistNameController.text,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Add songs"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: playlistBox.listenable(),
              builder: (context, Box<Playlist> box, _) {
                if (box.values.isEmpty) {
                  return  Center(
                      child: Text('No Playlists',
                           style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white70,
          )));
                } else {
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      final playlist = box.getAt(index);
                      return ListTile(
                        title: Text(
                          playlist?.name ?? 'Unknown Playlist',
                          style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white70,
          )
                        ),
                        subtitle: Text(
                          '${playlist?.songsId.length ?? 0} songs',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                          _showDeleteDialog(context,index);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Playlistsongs(
                                  playlistname: playlist!.name,
                                  playlist: playlist),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
