import 'package:bee_player/db/model/db_modal.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoPath;
  final String videoName;

  const VideoPlayerPage({super.key, required this.videoPath, required this.videoName});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();

   
    flickManager = FlickManager(
     
      // ignore: deprecated_member_use
      videoPlayerController: VideoPlayerController.network(widget.videoPath),
    );

    _updateLastPlayed();
  }

  Future<void> _updateLastPlayed() async {
    final videoDb = await Hive.openBox<VideoHive>('video_db');
    

    VideoHive? video = videoDb.values.firstWhere(
      (v) => v.path == widget.videoPath,
    
    );

    if (video != null) {
      video.lastPlayed = DateTime.now();
      video.save();
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FlickVideoPlayer(
          flickManager: flickManager,
        ),
      ),
    );
  }
}
