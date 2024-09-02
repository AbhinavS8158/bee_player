import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/Widgets/add_video.dart';
import 'package:flutter/material.dart';

class AddVideoForPlaylist extends StatefulWidget {
  final Videoplaylist playlist;
  const AddVideoForPlaylist({super.key, required this.playlist});

  @override
  State<AddVideoForPlaylist> createState() => _AddVideoForPlaylistState();
}

class _AddVideoForPlaylistState extends State<AddVideoForPlaylist> {
  List<bool> _checkboxStates = [];

  @override
  void initState() {
    super.initState();
    getAllVideos();
    videolistNotifier.addListener(_updateCheckboxStates);
  }

  @override
  void dispose() {
    videolistNotifier.removeListener(_updateCheckboxStates);
    super.dispose();
  }

  void _updateCheckboxStates() {
    final videos = videolistNotifier.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _checkboxStates = List.generate(
          videos.length,
          (index) => widget.playlist.videosId.contains(videos[index].id),
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
    final selectedVideoIds = <String>[];
    for (int i = 0; i < _checkboxStates.length; i++) {
      if (_checkboxStates[i]) {
        selectedVideoIds.add(videolistNotifier.value[i].id);
      }
    }

    setState(() {
      widget.playlist.videosId = selectedVideoIds;
    });

    // Save the updated playlist
    updatevideoPlaylist(widget.playlist); // Ensure this function updates the playlist in the database
    Navigator.pop(context, 1); // Return to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ADD VIDEOS",
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
        child: ValueListenableBuilder<List<VideoHive>>(
          valueListenable: videolistNotifier,
          builder: (context, videos, _) {
            
            if (_checkboxStates.length != videos.length) {
              _updateCheckboxStates();
            }

            if (videos.isEmpty) {
              return const Center(child: Text("No videos available", style: TextStyle(color: Colors.white)));
            }

            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
           
                if (index >= _checkboxStates.length) {
                  return Container(); // or any other placeholder widget
                }

                return Addvideos(
                  index: index,
                  item: videos[index],
                  isChecked: _checkboxStates[index],
                  onCheckboxChanged: (value) => _handleCheckboxChanged(index, value),video:  const [],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
