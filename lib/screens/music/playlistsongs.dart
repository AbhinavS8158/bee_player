import 'dart:async';
import 'dart:developer';

import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/add_song_for_playlist.dart';
import 'package:bee_player/screens/music/music_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Playlistsongs extends StatefulWidget {
  final String playlistname;
  final Playlist playlist;

  const Playlistsongs({super.key, required this.playlistname, required this.playlist});

  @override
  State<Playlistsongs> createState() => _PlaylistsongsState();
}

class _PlaylistsongsState extends State<Playlistsongs> {
  late Box<Playlist> playlistBox;
  late Box<SongHive> songBox;
  List<SongHive> playlistSongs = [];

  @override
  void initState() {
    super.initState();
    playlistBox = Hive.box<Playlist>('playlists');
    songBox = Hive.box<SongHive>('songs');
    getAllPlaylistSong();
  }

  Future<void> getAllPlaylistSong() async {
    final List<SongHive> fetchedSongs = await getPlaylistSong(widget.playlist);
    setState(() {
      playlistSongs = fetchedSongs;
    });
  }

  void _showDeleteDialog(SongHive song) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('Delete Song', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to delete this song from the playlist?', style: TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _deleteSongFromPlaylist(song); // Call the delete function
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteSongFromPlaylist(SongHive song) async {
    await deleteSongFromPlaylist(widget.playlist, song);
    getAllPlaylistSong(); // Refresh the playlist songs
  }

  void _editPlaylistName() {
    TextEditingController nameController = TextEditingController(text: widget.playlist.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Edit Playlist Name', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: nameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter new playlist name',
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.playlist.name = nameController.text;
                updatePlaylist(widget.playlist); 
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
        title: Text(
          widget.playlist.name,
          style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _editPlaylistName,
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: playlistSongs.isEmpty
          ? const Center(
              child: Text(
                'No songs',
                style: TextStyle(color: Colors.teal),
              ),
            )
          : ListView.builder(
              itemCount: playlistSongs.length,
              itemBuilder: (context, index) {
                final song = playlistSongs[index];
                log("Song path: ${song.path}");
                return ListTile(
                  leading: const Icon(Icons.music_note, color: Colors.white),
                  title: Text(
                    song.title,
                    style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
                  ),
                  subtitle: Text(song.artist, style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      _showDeleteDialog(song);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicScreen(
                          index: index,
                          songs: playlistSongs,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AddSongsForPlaylist(
                playlist: widget.playlist,
              ),
            ),
          );

          if (value != null) {
            getAllPlaylistSong();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
