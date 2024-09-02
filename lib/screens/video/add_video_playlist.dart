import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/Widgets/add_video.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddVideoPlaylist extends StatefulWidget {
  final String playlistname;
  const AddVideoPlaylist({super.key, required this.playlistname});

  @override
  State<AddVideoPlaylist> createState() => _AddVideoPlaylistState();
}

class _AddVideoPlaylistState extends State<AddVideoPlaylist> {
  List<bool> _checkboxStates = [];

  @override
  void initState() {
    super.initState();
    getAllVideos();
    videolistNotifier.addListener(_updateCheckboxStates);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCheckboxStates();
    });
  }

  @override
  void dispose() {
    videolistNotifier.removeListener(_updateCheckboxStates);
    super.dispose();
  }

  void _updateCheckboxStates() {
    if (!mounted) return; 

    final videos = videolistNotifier.value;

    if (_checkboxStates.length != videos.length) {
      setState(() {
        _checkboxStates = List.generate(videos.length, (index) => false);
      });
    }
  }

  void _handleCheckboxChanged(int index, bool? value) {
    if (!mounted) return; 

    setState(() {
      if (value != null && index >= 0 && index < _checkboxStates.length) {
        _checkboxStates[index] = value;
      }
    });
  }

  Videoplaylist? getVideoPlaylistByName(String name) {
    final playlists = Hive.box<Videoplaylist>('video_playlist').values.toList();
    for (final playlist in playlists) {
      if (playlist.name == name) {
        return playlist;
      }
    }
    return null;
  }

  void updateVideoPlaylist(Videoplaylist updatedPlaylist) {
    final playlistBox = Hive.box<Videoplaylist>('video_playlist');
    playlistBox.put(updatedPlaylist.id, updatedPlaylist);
  }

  void _savePlaylist() {
    final selectedVideos = <String>[];
    final allVideos = videolistNotifier.value;

    for (int i = 0; i < _checkboxStates.length; i++) {
      if (_checkboxStates[i]) {
        selectedVideos.add(allVideos[i].id);
      }
    }

    if (selectedVideos.isNotEmpty) {
      
      final existingPlaylist = getVideoPlaylistByName(widget.playlistname);

      if (existingPlaylist != null) {
       
        final updatedVideos = List<String>.from(existingPlaylist.videosId);

        for (var videoId in selectedVideos) {
          if (!updatedVideos.contains(videoId)) {
            updatedVideos.add(videoId);
          }
        }

        final updatedPlaylist = Videoplaylist(
          id: existingPlaylist.id,
          name: widget.playlistname,
          videosId: updatedVideos,
        );

        updateVideoPlaylist(updatedPlaylist);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Playlist updated successfully!')),
        );
      } else {
        // Create a new playlist if it doesn't exist
        final id = DateTime.now().millisecond.toString();
        final newPlaylist = Videoplaylist(
          id: id,
          name: widget.playlistname,
          videosId: selectedVideos,
        );

        addVideoPlaylist(newPlaylist);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Playlist created successfully!')),
        );
      }

      Navigator.popAndPushNamed(context, '/VideoPlaylistScreen');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one video')),
      );
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
        child: ValueListenableBuilder<List<VideoHive>>(
          valueListenable: videolistNotifier,
          builder: (context, videos, _) {
            if (videos.isEmpty) {
              return const Center(
                child: Text('No videos found', style: TextStyle(color: Colors.white)),
              );
            }
            if (_checkboxStates.length != videos.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _updateCheckboxStates();
              });
            }
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                if (index >= _checkboxStates.length) {
                  return const SizedBox.shrink();
                }

                return Addvideos(
                  index: index,
                  item: videos[index],
                  video: videos,
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
