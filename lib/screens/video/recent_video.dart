import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/video/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_all_videos/model/thumbnail_controller.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';

class RecentVideo extends StatefulWidget {
  const RecentVideo({super.key});

  @override
  State<RecentVideo> createState() => _RecentVideoState();
}

class _RecentVideoState extends State<RecentVideo> {
  List<VideoHive> _recentlyPlayedVideos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentlyPlayedVideos();
  }

  Future<void> _loadRecentlyPlayedVideos() async {
    final videos = await getRecentlyPlayedVideosFromHive();
    setState(() {
      _recentlyPlayedVideos = videos;
      _isLoading = false;
    });
  }

  Future<void> _showClearConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Recently Played Videos'),
          content: const Text('Are you sure you want to clear the recently played videos?'),
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
                await resetVideoRecent();
                setState(() {
                  _loadRecentlyPlayedVideos();
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
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'R e c e n t l y    P l a y e d',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _recentlyPlayedVideos.isEmpty
          ? const Center(
              child: Text(
                'No item',
                style: TextStyle(color: Colors.red),
              ),
            )
          : ListView.builder(
              itemCount: _recentlyPlayedVideos.length,
              itemBuilder: (context, index) {
                final video = _recentlyPlayedVideos[index];
                final controller = ThumbnailController(
                  videoPath: video.path, // Ensure the path is correct
                );
                return ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 50,
                    child: ThumbnailTile(
                      thumbnailController: controller,
                    ),
                  ),
                  title: Text(video.name,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(video.duration,
                      style: const TextStyle(color: Colors.white54)),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(
                          videoPath: video.path,
                          videoName: video.name,
                        ),
                      ),
                    );
                    _loadRecentlyPlayedVideos();
                  },
                );
              },
            ),
    );
  }
}

Future<List<VideoHive>> getRecentlyPlayedVideosFromHive() async {
  final videoDb = await Hive.openBox<VideoHive>('video_db');
  List<VideoHive> allVideos = videoDb.values.toList();

  // Sort videos by the last played time, showing most recent first
  allVideos.sort((a, b) {
    if (a.lastPlayed == null && b.lastPlayed == null) return 0;
    if (a.lastPlayed == null) return 1;
    if (b.lastPlayed == null) return -1;
    return b.lastPlayed!.compareTo(a.lastPlayed!);
  });

  // Return only videos that have been played (lastPlayed is not null)
  return allVideos.where((video) => video.lastPlayed != null).toList();
}
