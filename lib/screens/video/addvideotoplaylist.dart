import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/video/detail_playlist.dart';
import 'package:bee_player/screens/video/videoplaylist.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistSelectionScreen extends StatefulWidget {
  final String videoId;

  const PlaylistSelectionScreen({super.key, required this.videoId});

  @override
  State<PlaylistSelectionScreen> createState() => _PlaylistSelectionScreenState();
}

class _PlaylistSelectionScreenState extends State<PlaylistSelectionScreen> {
  late Box<Videoplaylist> videoplaylistBox;
  Map<int, bool> selectedPlaylists = {};

  @override
  void initState() {
    super.initState();
    videoplaylistBox = Hive.box<Videoplaylist>('video_playlist');
  }

  void togglePlaylist(int index, bool? isSelected) {
    setState(() {
      selectedPlaylists[index] = isSelected ?? false;
    });
  }

  void addVideoToPlaylists() {
    for (int index in selectedPlaylists.keys) {
      if (selectedPlaylists[index] == true) {
        final playlist = videoplaylistBox.getAt(index);
        if (playlist != null && !playlist.videosId.contains(widget.videoId)) {
          playlist.videosId.add(widget.videoId);
          playlist.save();
        }
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VideoPlaylistScreen(),
      ),
    );
  }

  void addNewPlaylist(String playlistName) {
    if (playlistName.isNotEmpty) {
      final newPlaylist = Videoplaylist(
        id: DateTime.now().toString(), // Unique ID
        name: playlistName,
        videosId: [],
      );
      videoplaylistBox.add(newPlaylist);
    }
  }

  void showAddPlaylistDialog() {
    final TextEditingController playlistNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New Playlist"),
          content: TextField(
            controller: playlistNameController,
            decoration: const InputDecoration(hintText: "Enter playlist name"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                addNewPlaylist(playlistNameController.text);
                Navigator.pop(context);
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
        title: const Text(
          "P l a y l i s t",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: addVideoToPlaylists,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: videoplaylistBox.listenable(),
              builder: (context, Box<Videoplaylist> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Playlists',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      final playlist = box.getAt(index);
                      bool isSelected = selectedPlaylists[index] ?? false;

                      return ListTile(
                        title: Text(
                          playlist?.name ?? 'Unknown Playlist',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${playlist?.videosId.length ?? 0} videos',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            togglePlaylist(index, value);
                          },
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => DetailPlayList(playlist: playlist!),
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
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPlaylistDialog,
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
