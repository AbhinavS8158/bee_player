import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/video/add_video_for_playlist.dart';
import 'package:bee_player/screens/video/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_all_videos/model/thumbnail_controller.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';

class DetailPlayList extends StatefulWidget {
  final Videoplaylist playlist;

  const DetailPlayList({super.key, required this.playlist});

  @override
  State<DetailPlayList> createState() => _DetailPlayListState();
}

class _DetailPlayListState extends State<DetailPlayList> {
  List<VideoHive> playlistVideo = [];

  @override
  void initState() {
    super.initState();
    getAllPlaylistVideos();
  }

  Future<void> getAllPlaylistVideos() async {
    final List<VideoHive> fetchedVideos = await getPlaylistVideos(widget.playlist);
    setState(() {
      playlistVideo = fetchedVideos;
    });
  }

  void _showDeleteDialog(BuildContext context, VideoHive video) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('Remove Video', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to remove this video from the playlist?', style: TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Remove', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _deleteVideoFromPlaylist(video); 
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteVideoFromPlaylist(VideoHive video) async {
    await deleteVideoFromPlayList(widget.playlist, video);
    getAllPlaylistVideos();
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
                updatevideoPlaylist(widget.playlist);
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
      body: playlistVideo.isEmpty
          ?  Center(
              child: Text(
                'No videos',
                 style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
              ),
            )
          : ListView.builder(
              itemCount: playlistVideo.length,
              itemBuilder: (context, index) {
                final video = playlistVideo[index];

                return ListTile(
                  leading: SizedBox(
                    width: 80.0,
                    height: 60.0,
                    child: ThumbnailTile(
                      thumbnailController: ThumbnailController(videoPath: video.path),
                    ),
                  ),
                  title: Text(
                    video.name,
                     style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
                  ),
                  subtitle: Text(video.size, style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.white),
                    onPressed: () {
                      _showDeleteDialog(context, video);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(
                          videoName: video.name,
                          videoPath: video.path,
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
              builder: (ctx) => AddVideoForPlaylist(
                playlist: widget.playlist,
              ),
            ),
          );

          if (value != null) {
            getAllPlaylistVideos();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
