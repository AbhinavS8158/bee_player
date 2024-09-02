import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/Widgets/video_list.dart';
import 'package:bee_player/screens/video/recent_video.dart';
import 'package:bee_player/screens/video/videoplaylist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Watch extends StatefulWidget {
  const Watch({super.key});

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<VideoHive> _filteredVideos = [];

  @override
  void initState() {
    super.initState();
    getAllVideos(); // Ensure this method is defined and properly updates `videolistNotifier`
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _filteredVideos = videolistNotifier.value
          .where((video) =>
              video.path.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar( 
        automaticallyImplyLeading: false,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search videos',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              )
            :  Text(
                'Watch',
                 style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  buildVideoTile(
                    color: const Color.fromARGB(255, 2, 79, 50),
                    icon: Icons.music_note,
                    label: 'Playlist',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoPlaylistScreen(),
                        ),
                      );
                    },
                  ),
                  buildVideoTile(
                    color: const Color.fromARGB(255, 108, 96, 6),
                    icon: Icons.timelapse,
                    label: 'Recent',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const RecentVideo(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder<List<VideoHive>>(
                valueListenable: videolistNotifier,
                builder: (context, videos, _) {
                  final displayVideos = _searchController.text.isEmpty
                      ? videos
                      : _filteredVideos;

                  return displayVideos.isEmpty
                      ?  Center(
                          child: Text(
                            "No Videos",
                             style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
                          ),
                        )
                      : ListView.builder(
                          itemCount: displayVideos.length,
                          itemBuilder: (context, index) {
                            return videoList(context, index, displayVideos);
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideoTile({
    required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 5),
            Text(
              label,
              style: GoogleFonts.eduVicWaNtBeginner(
                            color: Colors.white,
          )
            ),
          ],
        ),
      ),
    );
  }
}
