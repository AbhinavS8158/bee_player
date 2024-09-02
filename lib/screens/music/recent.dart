import 'dart:async';

import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/music_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentlyPlayedWidget extends StatefulWidget {
  const RecentlyPlayedWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecentlyPlayedWidgetState createState() => _RecentlyPlayedWidgetState();
}

class _RecentlyPlayedWidgetState extends State<RecentlyPlayedWidget> {
  List<SongHive> _recentlyPlayedSongs = [];
  // ignore: unused_field
  bool _isLoading = true;
  // ignore: unused_field, prefer_typing_uninitialized_variables
  late final _fetchRecentlyPlayedSongs;

  @override
  void initState() {
    super.initState();
    _fetchRecentlyPlayedSongs = _loadRecentlyPlayedSongs();
  }

  Future<void> _loadRecentlyPlayedSongs() async {
    final songs = await getRecentlyPlayedSongs();
    setState(() {
      _recentlyPlayedSongs = songs;
      _isLoading = false;
    });
  }

  Future<void> _showClearConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Recently Played'),
          content: const Text('Are you sure you want to clear the recently played list?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Clear'),
              onPressed: () async {
                await resetRecent();
                setState(() {
                  _loadRecentlyPlayedSongs();
                });
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await _showClearConfirmationDialog();
            },
            icon: const Icon(Icons.restart_alt_outlined),
          )
        ],
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
        backgroundColor: Colors.black,
        title:  Text(
          'R e c e n t l y    P l a y e d',
          style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
        ),
      ),
      body: _recentlyPlayedSongs.isEmpty
          ? const Center(
              child: Text(
                'No item',
                style: TextStyle(color: Colors.red),
              ),
            )
          : ListView.builder(
              itemCount: _recentlyPlayedSongs.length,
              itemBuilder: (context, index) {
                final song = _recentlyPlayedSongs[index];
                return ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(song.title,  style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )),
                  subtitle: Text(song.artist,  style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white70,
          )),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MusicScreen(songs: _recentlyPlayedSongs, index: index);
                        },
                      ),
                    );
                    setState(() {
                      _loadRecentlyPlayedSongs();
                    });
                  },
                );
              },
            ),
    );
  }
}
