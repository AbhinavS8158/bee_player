import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/Widgets/add_song.dart';
import 'package:flutter/material.dart';

class AddSongsForPlaylist extends StatefulWidget {
  final Playlist playlist;
  const AddSongsForPlaylist({super.key, required this.playlist});

  @override
  State<AddSongsForPlaylist> createState() => _AddSongsForPlaylistState();
}

class _AddSongsForPlaylistState extends State<AddSongsForPlaylist> {
  List<bool> _checkboxStates = [];

  @override
  void initState() {
    super.initState();
    getAllSongs();
    songlistNotifier.addListener(_updateCheckboxStates);
  }

  @override
  void dispose() {
    songlistNotifier.removeListener(_updateCheckboxStates);
    super.dispose();
  }

  void _updateCheckboxStates() {
    final songs = songlistNotifier.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _checkboxStates = List.generate(
          songs.length,
          (index) => widget.playlist.songsId.contains(songs[index].id),
        );
      });
    });
  }

  void _handleCheckboxChanged(int index, bool? value) {
    setState(() {
      if (value != null) {
        _checkboxStates[index] = value;
      }
    });
  }

  void _updatePlaylist() {
  final selectedSongIds = <String>[];
  for (int i = 0; i < _checkboxStates.length; i++) {
    if (_checkboxStates[i]) {
      selectedSongIds.add(songlistNotifier.value[i].id);
    }
  }

  setState(() {
    widget.playlist.songsId = selectedSongIds;
  });

  // Save the updated playlist
  updatePlaylist(widget.playlist); // Assuming this function updates the playlist in the database
  Navigator.pop(context,1); // Return to previous screen
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ADD SONGS",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _updatePlaylist,
            icon: const Icon(Icons.check, color: Colors.white),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ValueListenableBuilder<List<SongHive>>(
          valueListenable: songlistNotifier,
          builder: (context, songs, _) {
            
            if (_checkboxStates.length != songs.length) {
              _updateCheckboxStates();
            }

            if (songs.isEmpty) {
              return const Center(child: Text("No songs available", style: TextStyle(color: Colors.white)));
            }

            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
           
                if (index >= _checkboxStates.length) {
                  return Container(); // or any other placeholder widget
                }

                return Addsongs(
                  index: index,
                  item: songs[index],
                  song: songs,
                  isChecked: _checkboxStates[index],
                  onCheckboxChanged: (value) => _handleCheckboxChanged(index, value),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
