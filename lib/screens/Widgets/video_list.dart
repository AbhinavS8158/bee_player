import 'dart:developer';

import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/video/addvideotoplaylist.dart';
import 'package:bee_player/screens/video/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_all_videos/model/thumbnail_controller.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';

Widget videoList(BuildContext context, int index, List<VideoHive> videoList) {
  final video = videoList[index];
  ThumbnailController controller =
      ThumbnailController(videoPath: video.path.toString());

  return ListTile(
    onTap: () {
      log("Video thumbnail path: ${video.thumbnail}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(
            videoPath: video.path,
            videoName: video.name,
          ),
        ),
      );
    },
    leading: SizedBox(
      width: 60,
      height: 50,
      child: ThumbnailTile(
        thumbnailController: controller,
      ),
    ),
    title: Text(
      video.name,
      style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Row(
      children: [
        Text('${video.size}    . ', style: const TextStyle(color: Colors.white54)),
        const SizedBox(width: 10), // Adds spacing between size and duration
        Text(video.duration, style: const TextStyle(color: Colors.amber)),
      ],
    ),
    trailing: IconButton(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onPressed: () {
        _showMoreOptions(context, video);
      },
    ),
  );
}

void _showMoreOptions(BuildContext context, VideoHive video) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.playlist_add),
            title: const Text('Add to playlist'),
            onTap: () {
              Navigator.of(context).pop(); 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaylistSelectionScreen(videoId: video.id),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
