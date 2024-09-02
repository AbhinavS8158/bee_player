import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/Widgets/add_song.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddPlaylist extends StatefulWidget {
  final String playlistname;
  const AddPlaylist({super.key, required this.playlistname});

  @override
  State<AddPlaylist> createState() => _AddPlaylistState();
}

class _AddPlaylistState extends State<AddPlaylist> {
  List<bool> _checkboxStates = [];

  @override
  void initState() {
    super.initState();
    songlistNotifier.addListener(_updateCheckboxStates);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCheckboxStates();
    });
  }

  @override
  void dispose() {
    songlistNotifier.removeListener(_updateCheckboxStates);
    super.dispose();
  }

  void _updateCheckboxStates() {
    final songs = songlistNotifier.value;
    
    if (_checkboxStates.length != songs.length) {
      setState(() {
        _checkboxStates = List.generate(songs.length, (index) => false);
      });
    }
  }

  void _handleCheckboxChanged(int index, bool? value) {
    setState(() {
      if (value != null && index >= 0 && index < _checkboxStates.length) {
        _checkboxStates[index] = value;
      }
    });
  }

  void _savePlaylist() {
    final selectedSongs = <String>[];
    final allSongs = songlistNotifier.value;

    for (int i = 0; i < _checkboxStates.length; i++) {
      if (_checkboxStates[i]) {
        selectedSongs.add(allSongs[i].id);
      }
    }

    if (selectedSongs.isNotEmpty) {
      final playlistBox = Hive.box<Playlist>('playlists');
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final newPlaylist = Playlist(
        id: id,
        name: widget.playlistname,
        songsId: selectedSongs,
      );

      playlistBox.add(newPlaylist);
      Navigator.popAndPushNamed(context, '/playlist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ADD PLAYLIST",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _savePlaylist,
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
            if (songs.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            
            if (_checkboxStates.length != songs.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _updateCheckboxStates();
              });
            }

            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                
                if (index >= _checkboxStates.length) {
                  return const SizedBox.shrink(); 
                }

                return Addsongs(
                  index: index,
                  item: songs[index],
                  song: songs,
                  isChecked: _checkboxStates[index],
                  onCheckboxChanged: (value) =>
                      _handleCheckboxChanged(index, value),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
